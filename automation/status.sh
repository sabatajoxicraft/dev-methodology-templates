#!/bin/bash

# 🎯 Methodology Status and Summary
# Shows the current state of the portable development methodology

set -e

echo "🎯 Portable Development Methodology - Status Report"
echo "=================================================="
echo ""

# Check if we're in the methodology directory
if [ -f "README.md" ] && [ -f "setup.sh" ]; then
    echo "📍 Current Location: $(pwd)"
    echo "✅ Methodology repository detected"
else
    echo "❌ Not in methodology repository"
    echo "💡 Navigate to your methodology directory first"
    exit 1
fi

echo ""
echo "📋 Repository Structure:"
echo "------------------------"

# Show directory structure
if command -v tree &> /dev/null; then
    tree -L 3 -I 'node_modules|.git'
else
    find . -type d -not -path '*/.*' | head -20 | sed 's|[^/]*/|- |g'
fi

echo ""
echo "🛠️ Available Scripts:"
echo "--------------------"
ls -la automation/*.sh | awk '{print "  📜 " $9 " (" $5 " bytes)"}'

echo ""
echo "📚 Templates Available:"
echo "----------------------"
find templates -name "*.template" -o -name "*.md" | head -10 | sed 's|^|  📄 |'

echo ""
echo "📖 Standards Documents:"
echo "----------------------"
ls standards/*.md 2>/dev/null | sed 's|^|  📋 |' || echo "  📋 No standards found"

echo ""
echo "🎯 Quick Usage:"
echo "---------------"
echo "  🚀 Initialize new project:"
echo "     git clone https://github.com/sabata-sa/dev-methodology-templates.git .methodology && .methodology/setup.sh"
echo ""
echo "  🧩 Create feature:"
echo "     ./automation/create-feature.sh feature-name"
echo ""
echo "  🔧 Create component:"
echo "     ./automation/create-component.sh ComponentName feature-name"
echo ""
echo "  📝 Update memory:"
echo "     ./automation/update-memory.sh \"Completed task description\""
echo ""
echo "  🚀 Deploy to GitHub:"
echo "     ./automation/deploy.sh [repository-name]"

echo ""
echo "📊 File Count Summary:"
echo "---------------------"
echo "  📄 Templates: $(find templates -type f | wc -l)"
echo "  🛠️ Scripts: $(find automation -name "*.sh" | wc -l)"
echo "  📋 Standards: $(find standards -name "*.md" 2>/dev/null | wc -l || echo 0)"
echo "  ⚙️ VS Code configs: $(find templates/vscode -type f | wc -l)"
echo "  📚 Documentation: $(find . -name "*.md" -not -path "./.git/*" | wc -l)"

echo ""
echo "🔍 Git Status:"
echo "-------------"
if [ -d ".git" ]; then
    git status --porcelain | head -10
    if [ -z "$(git status --porcelain)" ]; then
        echo "  ✅ Working directory clean"
    fi
    
    if git remote get-url origin &> /dev/null; then
        echo "  🔗 Remote: $(git remote get-url origin)"
    else
        echo "  ⚠️ No remote repository configured"
    fi
else
    echo "  ⚠️ Not a git repository"
fi

echo ""
echo "🎯 Next Steps:"
echo "-------------"
echo "1. 🚀 Deploy to GitHub for global access:"
echo "   ./automation/deploy.sh"
echo ""
echo "2. 🧪 Test in a new project:"
echo "   mkdir test-project && cd test-project"
echo "   git clone <your-repo> .methodology && .methodology/setup.sh"
echo ""
echo "3. 📤 Share with your team:"
echo "   Update team documentation with the methodology URL"
echo ""
echo "4. 🔄 Iterate and improve:"
echo "   Update methodology based on real-world usage"

echo ""
echo "✅ Methodology is ready for deployment!"
echo "🌟 Remember to star and share your methodology repository!"
echo ""

# Show methodology health score
TOTAL_FILES=$(find . -type f -not -path "./.git/*" | wc -l)
SCRIPT_FILES=$(find . -name "*.sh" | wc -l)
TEMPLATE_FILES=$(find templates -type f | wc -l)
DOC_FILES=$(find . -name "*.md" -not -path "./.git/*" | wc -l)

echo "🏆 Methodology Health Score:"
echo "============================="
echo "📄 Total Files: $TOTAL_FILES"
echo "🛠️ Automation Scripts: $SCRIPT_FILES"
echo "📋 Templates: $TEMPLATE_FILES"
echo "📚 Documentation: $DOC_FILES"

# Calculate health percentage
HEALTH_SCORE=$((($SCRIPT_FILES * 20 + $TEMPLATE_FILES * 15 + $DOC_FILES * 10) / 10))
if [ $HEALTH_SCORE -gt 100 ]; then
    HEALTH_SCORE=100
fi

echo "💯 Health Score: ${HEALTH_SCORE}%"

if [ $HEALTH_SCORE -ge 90 ]; then
    echo "🌟 Excellent! Your methodology is comprehensive and ready."
elif [ $HEALTH_SCORE -ge 70 ]; then
    echo "👍 Good! Consider adding more templates or documentation."
elif [ $HEALTH_SCORE -ge 50 ]; then
    echo "⚠️ Needs improvement. Add more automation and templates."
else
    echo "❌ Requires significant work to be production-ready."
fi