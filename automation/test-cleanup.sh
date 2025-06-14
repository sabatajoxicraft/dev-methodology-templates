#!/bin/bash

# 🧪 Test Cleanup and Re-run Script
# Deletes test folder and optionally re-runs the methodology test

set -e

TEST_DIR="/c/apps/test"

echo "🧪 Methodology Test Cleanup Script"
echo "=================================="

# Check if test directory exists
if [ -d "$TEST_DIR" ]; then
    echo "📁 Found test directory: $TEST_DIR"
    
    # Show what's in the test directory
    echo "📋 Current contents:"
    ls -la "$TEST_DIR" 2>/dev/null || echo "   (empty or inaccessible)"
    
    echo ""
    read -p "🗑️ Delete the test directory? (y/N): " delete_choice
    
    if [[ $delete_choice =~ ^[Yy]$ ]]; then
        echo "🗑️ Deleting test directory..."
        rm -rf "$TEST_DIR"
        echo "✅ Test directory deleted successfully!"
    else
        echo "❌ Test directory deletion cancelled."
        exit 0
    fi
else
    echo "ℹ️ Test directory $TEST_DIR does not exist."
fi

echo ""
read -p "🚀 Create new test directory and run methodology test? (y/N): " test_choice

if [[ $test_choice =~ ^[Yy]$ ]]; then
    echo ""
    echo "🧪 Creating new test and running methodology..."
    echo "=============================================="
    
    # Create test directory
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    echo "📁 Created and entered: $(pwd)"
    echo ""
    echo "🚀 Running methodology initialization..."
    echo "Command: git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh"
    echo ""
    
    # Run the methodology setup
    if git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh; then
        echo ""
        echo "✅ Methodology test completed successfully!"
        echo ""
        echo "📋 Test results:"
        echo "📁 Directory: $(pwd)"
        echo "🗂️ Files created:"
        ls -la | grep -v "^d" | tail -n +2 | sed 's/^/   /'
        echo ""
        echo "📂 Directories created:"
        ls -la | grep "^d" | tail -n +3 | sed 's/^/   /'
        
        # Check git status
        if [ -d ".git" ]; then
            echo ""
            echo "🔍 Git status:"
            git status --porcelain | head -10 | sed 's/^/   /' || echo "   Working directory clean"
        fi
        
        # Check for methodology folder
        if [ -d ".methodology" ]; then
            echo ""
            echo "⚠️ Note: .methodology folder exists (this is normal)"
            echo "🔍 Git tracking status of .methodology:"
            if git ls-files | grep -q "^\.methodology"; then
                echo "   ❌ .methodology is being tracked by git (this should be fixed)"
            else
                echo "   ✅ .methodology is not tracked by git (correct)"
            fi
        fi
        
    else
        echo ""
        echo "❌ Methodology test failed!"
        echo "💡 Check the error messages above for troubleshooting."
    fi
    
else
    echo "ℹ️ Test cancelled. Directory cleaned up."
fi

echo ""
echo "🎯 Test cleanup script completed!"
echo ""
echo "💡 Useful commands for manual testing:"
echo "   cd $TEST_DIR"
echo "   git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh"
echo "   ls -la"
echo "   git status"