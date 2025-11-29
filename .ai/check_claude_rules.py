#!/usr/bin/env python3
"""
CLAUDE.md rules checker for Flutter Hackathon Thema project
Ensures all Dart files comply with project standards
"""

import json
import os
import sys
import hashlib
import subprocess
from datetime import datetime
from pathlib import Path

class ClaudeRulesChecker:
    def __init__(self):
        self.project_root = Path(__file__).parent.parent
        self.ai_dir = self.project_root / '.ai'
        self.project_files_path = self.ai_dir / 'project_files.json'
        self.header_template_path = self.ai_dir / 'dart_header_template.txt'
        self.errors = []
        self.warnings = []
        self.is_feature_branch = self._check_feature_branch()

    def _check_feature_branch(self):
        """Check if current branch is a feature branch"""
        try:
            result = subprocess.run(
                ['git', 'branch', '--show-current'],
                capture_output=True, text=True, cwd=self.project_root
            )
            branch_name = result.stdout.strip()
            # Feature branches start with 'feature/' or 'fix/' or 'hotfix/'
            return branch_name.startswith(('feature/', 'fix/', 'hotfix/'))
        except Exception:
            return False

    def load_header_template(self):
        """Load the required header template"""
        with open(self.header_template_path, 'r') as f:
            return f.read()

    def check_header_compliance(self, file_path):
        """Check if file has the required header"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Check for mandatory header markers
        required_markers = [
            "FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE",
            "This file is managed by AI development rules (CLAUDE.md)",
            "Architecture: Three-Layer",
            "State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)",
            "Router: go_router 16.x (MANDATORY)"
        ]

        for marker in required_markers:
            if marker not in content:
                self.errors.append(f"{file_path}: Missing required header marker: '{marker}'")
                return False

        return True

    def check_provider_patterns(self, file_path):
        """Check if providers use @riverpod annotation pattern"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Check for old-style Provider patterns that should use @riverpod
        if 'Provider(' in content or 'StateNotifierProvider(' in content:
            if '@riverpod' not in content:
                self.warnings.append(
                    f"{file_path}: Using old-style Provider. Consider migrating to @riverpod annotation"
                )

    def check_widget_patterns(self, file_path):
        """Check widget implementation patterns"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Check for method-based widgets (anti-pattern)
        lines = content.split('\n')
        in_class = False
        class_depth = 0

        for i, line in enumerate(lines):
            stripped = line.strip()

            # Track class boundaries
            if 'class ' in stripped and '{' in stripped:
                in_class = True
                class_depth = line.count('{') - line.count('}')
            elif in_class:
                class_depth += line.count('{') - line.count('}')
                if class_depth <= 0:
                    in_class = False

            # Check for widget methods outside of classes
            if (stripped.startswith('Widget ') and '(' in stripped and
                not in_class and not stripped.startswith('Widget build(')):
                # Found a method-based widget
                method_name = stripped.split('(')[0].replace('Widget ', '').strip()
                if not method_name.startswith('_') or not any('class' in l for l in lines[max(0, i-10):i]):
                    self.errors.append(f"{file_path}: Widget defined as method instead of class")
                    break

        # Check for proper widget usage with hooks
        if 'ConsumerWidget' in content and 'HookConsumerWidget' not in content:
            if 'use' in content:  # Has hooks
                self.warnings.append(
                    f"{file_path}: Using hooks with ConsumerWidget instead of HookConsumerWidget"
                )

    def check_documentation(self, file_path):
        """Check documentation standards"""
        with open(file_path, 'r') as f:
            lines = f.readlines()

        in_code_block = False

        for i, line in enumerate(lines):
            # Check for English documentation in public APIs
            if line.strip().startswith('///'):
                # Check if we're entering or leaving a code block
                if '```' in line:
                    in_code_block = not in_code_block
                    continue

                # Skip validation inside code blocks
                if in_code_block:
                    continue

                # Check for Japanese characters (hiragana, katakana, kanji)
                has_hiragana = any(0x3040 <= ord(char) <= 0x309F for char in line)
                has_katakana = any(0x30A0 <= ord(char) <= 0x30FF for char in line)
                has_kanji = any(0x4E00 <= ord(char) <= 0x9FAF for char in line)

                # If no Japanese characters are found, it's likely English
                if not (has_hiragana or has_katakana or has_kanji):
                    # Skip lines that are only symbols, brackets, or very short
                    content = line.strip().replace('///', '').strip()
                    # Skip common documentation patterns that are acceptable in English
                    if (len(content) > 3 and any(c.isalpha() for c in content) and
                        not content.startswith('[') and  # Skip reference links
                        'dart' not in content.lower() and  # Skip dart-specific terms
                        not all(c in '[](){}.,;:' or c.isspace() or c.isdigit() for c in content)):
                        self.warnings.append(
                            f"{file_path}:{i+1}: Public API documentation should be in Japanese"
                        )

    def check_test_coverage(self):
        """Check if test coverage meets recommendations"""
        coverage_file = self.project_root / 'coverage' / 'lcov.info'
        if coverage_file.exists():
            # Parse coverage file and exclude auto-generated files
            with open(coverage_file, 'r') as f:
                content = f.read()

            # Parse lcov.info file to calculate coverage excluding auto-generated files
            total_lines = 0
            hit_lines = 0
            current_file = ""
            current_lf = 0
            current_lh = 0

            lines = content.split('\n')
            for line in lines:
                line = line.strip()
                if line.startswith('SF:'):
                    current_file = line[3:]
                elif line.startswith('LF:'):
                    current_lf = int(line.split(':')[1])
                elif line.startswith('LH:'):
                    current_lh = int(line.split(':')[1])
                elif line == 'end_of_record':
                    # Check if we should include this file
                    if current_file and not (
                        current_file.endswith('.g.dart') or
                        current_file.endswith('.freezed.dart') or
                        current_file.endswith('.gr.dart') or
                        current_file.endswith('.mocks.dart')
                    ):
                        total_lines += current_lf
                        hit_lines += current_lh

                    # Reset for next file
                    current_file = ""
                    current_lf = 0
                    current_lh = 0

            # Check coverage percentage
            if total_lines > 0:
                coverage_percent = (hit_lines / total_lines) * 100
                if coverage_percent < 80.0:
                    self.errors.append(
                        f"Test coverage is {coverage_percent:.1f}% (excluding auto-generated files), "
                        f"below required 80%!"
                    )
                    print(f"❌ Test coverage: {coverage_percent:.1f}% ({hit_lines}/{total_lines} lines)")
                else:
                    print(f"✅ Test coverage: {coverage_percent:.1f}% ({hit_lines}/{total_lines} lines)")
            else:
                self.errors.append("No coverage data found for source files")
        else:
            print("⚠️  No coverage data found. Run tests with coverage to generate.")

    def check_imports_and_dependencies(self, file_path):
        """Check for proper dependency usage"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Check for feature-to-feature dependencies
        file_parts = str(file_path).split('/')
        if 'features' in file_parts:
            current_feature = file_parts[file_parts.index('features') + 1]

            # Look for imports from other features
            import_lines = [line for line in content.split('\n') if 'import' in line and 'features/' in line]
            for import_line in import_lines:
                if f'features/{current_feature}' not in import_line and 'features/' in import_line:
                    other_feature = import_line.split('features/')[1].split('/')[0]
                    self.errors.append(
                        f"{file_path}: Illegal cross-feature import from '{other_feature}'"
                    )

    def update_file_header(self, file_path):
        """Update file header with timestamp and hash"""
        with open(file_path, 'r') as f:
            content = f.read()

        # Calculate file hash
        file_hash = hashlib.md5(content.encode()).hexdigest()[:8]
        timestamp = datetime.now().isoformat()

        # Update placeholders
        content = content.replace('{timestamp}', timestamp)
        content = content.replace('{file_hash}', file_hash)

        return content

    def run_checks(self):
        """Run all checks on Dart files"""
        # Load project files
        if not self.project_files_path.exists():
            print("⚠️  project_files.json not found. Generating...")
            self._generate_project_files()

        with open(self.project_files_path, 'r') as f:
            dart_files = json.load(f)

        print("🔍 Checking CLAUDE.md compliance...")
        if self.is_feature_branch:
            print("📌 Feature branch detected: some checks are warnings instead of errors")

        for file_path in dart_files:
            # Skip auto-generated files and Firebase options files
            if (file_path.endswith('.g.dart') or
                file_path.endswith('.freezed.dart') or
                file_path.endswith('.gr.dart') or
                'firebase_options_' in file_path):
                continue

            if os.path.exists(file_path):
                print(f"  Checking: {file_path}")
                self.check_header_compliance(file_path)
                self.check_provider_patterns(file_path)
                self.check_widget_patterns(file_path)
                self.check_documentation(file_path)
                self.check_imports_and_dependencies(file_path)

        self.check_test_coverage()

        # Report results
        if self.errors:
            print("\n❌ ERRORS FOUND:")
            for error in self.errors:
                print(f"  - {error}")
            return False

        if self.warnings:
            print("\n⚠️  WARNINGS:")
            for warning in self.warnings:
                print(f"  - {warning}")

        print("\n✅ All CLAUDE.md rules satisfied!")
        return True

    def _generate_project_files(self):
        """Generate project_files.json from current lib directory"""
        result = subprocess.run(
            ['find', 'lib', '-name', '*.dart', '-type', 'f'],
            capture_output=True, text=True, cwd=self.project_root
        )

        dart_files = [line.strip() for line in result.stdout.split('\n') if line.strip()]

        with open(self.project_files_path, 'w') as f:
            json.dump(dart_files, f, indent=2)

        print(f"✅ Generated project_files.json with {len(dart_files)} files")

if __name__ == "__main__":
    checker = ClaudeRulesChecker()
    success = checker.run_checks()
    sys.exit(0 if success else 1)
