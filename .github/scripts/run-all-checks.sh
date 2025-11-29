#!/bin/bash
# Run all CI checks locally before pushing
# This script mimics the GitHub Actions workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Running all CI checks locally...${NC}\n"

# Function to print step header
print_step() {
    echo -e "${YELLOW}$1${NC}"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}\n"
}

# Function to print error
print_error() {
    echo -e "${RED}❌ $1${NC}\n"
}

# Step 1: Install dependencies
print_step "📦 1/6: Installing dependencies..."
if fvm flutter pub get; then
    print_success "Dependencies installed"
else
    print_error "Failed to install dependencies"
    exit 1
fi

# Step 2: Generate code
print_step "⚙️  2/6: Generating code..."
if fvm flutter pub run build_runner build --delete-conflicting-outputs; then
    print_success "Code generation completed"
else
    print_error "Code generation failed"
    exit 1
fi

# Step 3: Static analysis
print_step "🔎 3/6: Running static analysis..."
if fvm flutter analyze; then
    print_success "Static analysis passed"
else
    print_error "Static analysis failed"
    exit 1
fi

# Step 4: Format check
print_step "✨ 4/6: Checking code formatting..."
if ./.github/scripts/validate-formatting.sh; then
    print_success "Formatting check passed"
else
    print_error "Formatting check failed"
    echo -e "${YELLOW}Run 'fvm dart format .' to fix formatting${NC}\n"
    exit 1
fi

# Step 5: CLAUDE.md compliance
print_step "📋 5/6: Checking CLAUDE.md compliance..."
if python3 .ai/check_claude_rules.py; then
    print_success "CLAUDE.md compliance check passed"
else
    print_error "CLAUDE.md compliance check failed"
    exit 1
fi

# Step 6: Run tests
print_step "🧪 6/6: Running tests with coverage..."
if fvm flutter test --coverage; then
    print_success "All tests passed"
else
    print_error "Tests failed"
    exit 1
fi

# All checks passed
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ All CI checks passed successfully! ✅${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "${BLUE}You're ready to push your changes! 🚀${NC}\n"

exit 0
