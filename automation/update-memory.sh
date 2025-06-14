#!/bin/bash

# 🎯 Update Project Memory Script
# Updates project_memory.md with new developments and context

set -e

if [ $# -eq 0 ]; then
    echo "❌ Usage: $0 \"<update message>\" [section]"
    echo "📋 Examples:"
    echo "   $0 \"Completed user authentication feature\""
    echo "   $0 \"Fixed navigation bug in mobile view\" \"Technical Debt\""
    echo "   $0 \"Added dark theme support\" \"Features\""
    exit 1
fi

UPDATE_MESSAGE=$1
SECTION=${2:-"Current Sprint / Phase"}

echo "📝 Updating project memory..."

# Check if project_memory.md exists
if [ ! -f "project_memory.md" ]; then
    echo "❌ project_memory.md not found!"
    echo "💡 Run the setup script first: .methodology/setup.sh"
    exit 1
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d %H:%M')

# Create backup
cp project_memory.md project_memory.md.backup

# Determine the update type based on keywords
UPDATE_TYPE="info"
if echo "$UPDATE_MESSAGE" | grep -qi "complet\|finish\|done"; then
    UPDATE_TYPE="completed"
elif echo "$UPDATE_MESSAGE" | grep -qi "start\|begin\|working"; then
    UPDATE_TYPE="in-progress"
elif echo "$UPDATE_MESSAGE" | grep -qi "fix\|bug\|issue\|error"; then
    UPDATE_TYPE="fix"
elif echo "$UPDATE_MESSAGE" | grep -qi "add\|new\|creat"; then
    UPDATE_TYPE="feature"
elif echo "$UPDATE_MESSAGE" | grep -qi "updat\|modif\|chang"; then
    UPDATE_TYPE="update"
elif echo "$UPDATE_MESSAGE" | grep -qi "remov\|delet\|deprecat"; then
    UPDATE_TYPE="removal"
elif echo "$UPDATE_MESSAGE" | grep -qi "deploy\|release\|publish"; then
    UPDATE_TYPE="deployment"
elif echo "$UPDATE_MESSAGE" | grep -qi "test\|spec"; then
    UPDATE_TYPE="testing"
elif echo "$UPDATE_MESSAGE" | grep -qi "refactor\|restructur\|reorganiz"; then
    UPDATE_TYPE="refactor"
elif echo "$UPDATE_MESSAGE" | grep -qi "doc\|comment\|readme"; then
    UPDATE_TYPE="documentation"
fi

# Select emoji based on update type
case $UPDATE_TYPE in
    "completed")     EMOJI="✅" ;;
    "in-progress")   EMOJI="🚧" ;;
    "fix")           EMOJI="🐛" ;;
    "feature")       EMOJI="✨" ;;
    "update")        EMOJI="🔄" ;;
    "removal")       EMOJI="🗑️" ;;
    "deployment")    EMOJI="🚀" ;;
    "testing")       EMOJI="🧪" ;;
    "refactor")      EMOJI="♻️" ;;
    "documentation") EMOJI="📚" ;;
    *)               EMOJI="📝" ;;
esac

# Create the update entry
UPDATE_ENTRY="${EMOJI} **${DATE}**: ${UPDATE_MESSAGE}"

# Function to add update to a specific section
add_to_section() {
    local section=$1
    local entry=$2
    
    # Check if section exists
    if grep -q "## 🧩 Features" project_memory.md && [ "$section" = "Features" ]; then
        # Add to Features section
        sed -i "/## 🧩 Features/,/^## /{ /^## /!{ /### Completed Features/a\\
$entry
        }}" project_memory.md
    elif grep -q "## 🔧 Technical Debt" project_memory.md && [ "$section" = "Technical Debt" ]; then
        # Add to Technical Debt section
        sed -i "/## 🔧 Technical Debt/,/^## /{ /^## /!{ /### Known Issues/a\\
$entry
        }}" project_memory.md
    elif grep -q "## 📋 Current Sprint" project_memory.md; then
        # Add to Current Sprint section (default)
        sed -i "/## 📋 Current Sprint/,/^## /{ /^## /!{ /### In Progress/a\\
$entry
        }}" project_memory.md
    else
        # If sections don't exist, add to the end before notes
        sed -i "/## 📝 Notes & Context/i\\
\\
### Recent Updates\\
$entry\\
" project_memory.md
    fi
}

# Add the update to the appropriate section
add_to_section "$SECTION" "$UPDATE_ENTRY"

# Update the "Last Updated" timestamp at the top
sed -i "s/\*\*Last Updated\*\*:.*/\*\*Last Updated\*\*: $DATE/" project_memory.md

# Show git status if in a git repository
if [ -d ".git" ]; then
    echo ""
    echo "📊 Git status:"
    git status --porcelain | head -10
    
    # Offer to commit the change
    echo ""
    read -p "🤔 Commit this update to git? (y/N): " commit_choice
    if [[ $commit_choice =~ ^[Yy]$ ]]; then
        git add project_memory.md
        git commit -m "docs(memory): ${UPDATE_MESSAGE}"
        echo "✅ Changes committed to git"
    fi
fi

echo ""
echo "✅ Project memory updated successfully!"
echo "📝 Added: $UPDATE_ENTRY"
echo ""
echo "💡 Tip: Review your project_memory.md regularly to track progress and maintain context."

# Show recent updates
echo ""
echo "📋 Recent updates:"
grep -A 5 "Recent Updates\|In Progress\|Completed Features" project_memory.md | head -15