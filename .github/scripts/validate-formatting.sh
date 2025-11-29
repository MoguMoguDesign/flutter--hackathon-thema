#!/bin/bash
# Formatting validation script for Flutter Hackathon Thema project
# Ensures all Dart code follows the project's formatting standards

set -e

echo "🔍 Checking code formatting..."

# Run dart format in dry-run mode to check for formatting issues
# --set-exit-if-changed: Exit with code 1 if any files need formatting
# --output none: Don't show the formatted output, just check
dart format --set-exit-if-changed --output none .

if [ $? -eq 0 ]; then
    echo "✅ All files are properly formatted!"
    exit 0
else
    echo "❌ Formatting issues found!"
    echo ""
    echo "Please run the following command to fix formatting:"
    echo "  dart format ."
    echo ""
    echo "Or if using FVM:"
    echo "  fvm dart format ."
    exit 1
fi
