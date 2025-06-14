#!/bin/bash

# 🧹 Test Cleanup Script
# Removes the test project directory and re-runs methodology initialization
# Uses this to verify the setup works correctly without embedded git warnings

set -e

TEST_DIR="/c/apps/test"

echo "🧹 Cleaning up test environment..."

# Check if test directory exists
if [ -d "$TEST_DIR" ]; then
    echo "🗑️ Removing existing test directory: $TEST_DIR"
    rm -rf "$TEST_DIR"
    echo "✅ Test directory removed"
else
    echo "ℹ️ Test directory doesn't exist, nothing to clean"
fi

# Create fresh test directory
echo "📁 Creating fresh test directory..."
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo "🎯 Running methodology initialization test..."
echo "📋 Command: git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh"
echo ""

# Run the methodology setup
git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh

echo ""
echo "🔍 Test Results:"
echo "================"

# Check for embedded repository warnings in git status
if git status 2>&1 | grep -q "embedded"; then
    echo "❌ FAILED: Still getting embedded repository warnings"
    exit 1
else
    echo "✅ PASSED: No embedded repository warnings"
fi

# Check if .methodology is in git tracking
if git ls-files | grep -q "^\.methodology"; then
    echo "❌ FAILED: .methodology is still being tracked by git"
    exit 1
else
    echo "✅ PASSED: .methodology is properly excluded from git"
fi

# Check if .gitignore contains .methodology exclusion
if grep -q "\.methodology/" .gitignore; then
    echo "✅ PASSED: .gitignore properly excludes .methodology/"
else
    echo "❌ FAILED: .gitignore missing .methodology/ exclusion"
    exit 1
fi

# Check if essential files were created
ESSENTIAL_FILES=("project_memory.md" "docs/architecture.md" "scripts/create-feature" ".vscode/tasks.json")
for file in "${ESSENTIAL_FILES[@]}"; do
    if [ -f "$file" ] || [ -L "$file" ]; then
        echo "✅ PASSED: $file created successfully"
    else
        echo "❌ FAILED: $file is missing"
        exit 1
    fi
done

# Check git history
COMMIT_COUNT=$(git rev-list --count HEAD)
if [ "$COMMIT_COUNT" -eq 1 ]; then
    echo "✅ PASSED: Clean git history with single initialization commit"
else
    echo "⚠️ WARNING: Expected 1 commit, found $COMMIT_COUNT"
fi

echo ""
echo "🎉 All tests passed! Methodology setup is working correctly."
echo ""
echo "📊 Test Summary:"
echo "- ✅ No embedded repository warnings"
echo "- ✅ .methodology properly excluded from git"
echo "- ✅ All essential files created"
echo "- ✅ Clean project structure"
echo ""
echo "🧪 Test directory location: $TEST_DIR"
echo "💡 You can inspect the test results or run 'rm -rf $TEST_DIR' to clean up"