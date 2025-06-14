#!/bin/bash

# 🚀 Deploy Methodology to GitHub
# Creates a GitHub repository and pushes the methodology for global access

set -e

echo "🚀 Deploying Portable Development Methodology to GitHub..."

# Check if we're in the methodology directory
if [ ! -f "README.md" ] || [ ! -f "setup.sh" ]; then
    echo "❌ Please run this script from the dev-methodology-templates directory"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📂 Initializing git repository..."
    git init
fi

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "💡 Install it from: https://cli.github.com/"
    echo "   Or manually create the repository and push"
    exit 1
fi

# Get repository name
REPO_NAME=${1:-"dev-methodology-templates"}
echo "📋 Repository name: $REPO_NAME"

# Check if user is logged in to GitHub CLI
if ! gh auth status &> /dev/null; then
    echo "🔑 Please login to GitHub CLI first:"
    echo "   gh auth login"
    exit 1
fi

# Get GitHub username
GITHUB_USER=$(gh api user --jq .login)
echo "👤 GitHub user: $GITHUB_USER"

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "🚫 Creating .gitignore..."
    cat > .gitignore << 'EOF'
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log

# Temporary files
*.tmp
*.temp
temp/
tmp/

# Backup files
*.backup
*.bak

# System files
.bash_history
.zsh_history
EOF
fi

# Stage all files
echo "📝 Staging files..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "ℹ️ No changes to commit"
else
    # Commit the changes
    echo "💾 Committing changes..."
    git commit -m "🎯 feat: portable development methodology

- Complete setup script for any environment
- Comprehensive templates for projects
- Automation scripts for features and components
- VS Code integration and configuration
- TypeScript standards and best practices
- Documentation templates
- Testing and deployment automation

This methodology works across local, remote, Codespaces, and container environments."
fi

# Check if repository exists
if gh repo view "$GITHUB_USER/$REPO_NAME" &> /dev/null; then
    echo "📦 Repository $REPO_NAME already exists"
    
    # Ask if user wants to push anyway
    read -p "🤔 Push changes to existing repository? (y/N): " push_choice
    if [[ ! $push_choice =~ ^[Yy]$ ]]; then
        echo "❌ Deployment cancelled"
        exit 0
    fi
else
    # Create the repository
    echo "📦 Creating GitHub repository..."
    gh repo create "$REPO_NAME" \
        --public \
        --description "🎯 Portable Development Methodology - Consistent, documented, and maintainable development across any environment" \
        --add-readme=false
fi

# Add remote if it doesn't exist
if ! git remote get-url origin &> /dev/null; then
    echo "🔗 Adding GitHub remote..."
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
fi

# Get current branch name
CURRENT_BRANCH=$(git branch --show-current)
if [ -z "$CURRENT_BRANCH" ]; then
    CURRENT_BRANCH="main"
    git checkout -b main
fi

# Push to GitHub
echo "⬆️ Pushing to GitHub..."
git push -u origin "$CURRENT_BRANCH"

# Create a release
echo "🏷️ Creating initial release..."
if ! gh release view v1.0.0 &> /dev/null; then
    gh release create v1.0.0 \
        --title "🎯 Portable Development Methodology v1.0.0" \
        --notes "## 🚀 Initial Release

This release includes:

### 🎯 Core Features
- **Universal Setup Script**: Works in any environment (local, Codespaces, remote, containers)
- **Project Templates**: Comprehensive templates for all project types
- **Automation Scripts**: Feature and component creation automation
- **Documentation Templates**: Complete docs structure with architecture, style guides, and API conventions

### 🛠️ VS Code Integration
- **Task Definitions**: Integrated tasks for common workflows
- **Debug Configurations**: Ready-to-use debugging setups
- **Extension Recommendations**: Curated extension list for optimal development
- **Settings**: Portable settings that work across environments

### 📚 Standards & Best Practices
- **TypeScript Standards**: Comprehensive coding standards
- **Git Conventions**: Semantic commit messages and branching strategy
- **Component Hierarchy**: Systematic approach to building components
- **Testing Strategy**: Unit, integration, and E2E testing patterns

### 🌐 Environment Support
- ✅ Local Development
- ✅ GitHub Codespaces
- ✅ VS Code Remote SSH
- ✅ Docker Containers
- ✅ Cloud IDEs

## 🎯 Quick Start

\`\`\`bash
git clone https://github.com/$GITHUB_USER/$REPO_NAME.git .methodology && .methodology/setup.sh
\`\`\`

## 📋 What's Included
- Complete project initialization
- Feature-based code organization
- Automated component generation
- Comprehensive documentation templates
- VS Code workspace optimization
- Cross-environment compatibility

Perfect for developers who want consistent, maintainable, and well-documented projects regardless of their development environment."
fi

echo ""
echo "✅ Methodology successfully deployed to GitHub!"
echo ""
echo "📍 Repository URL: https://github.com/$GITHUB_USER/$REPO_NAME"
echo "🔗 Clone URL: https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo ""
echo "🎯 Usage in new projects:"
echo "   git clone https://github.com/$GITHUB_USER/$REPO_NAME.git .methodology && .methodology/setup.sh"
echo ""
echo "📋 Update your VS Code Copilot instructions with:"
echo "   git clone https://github.com/$GITHUB_USER/$REPO_NAME.git .methodology && .methodology/setup.sh"
echo ""
echo "🌟 Don't forget to star the repository and share it with your team!"

# Offer to update local VS Code settings
echo ""
read -p "🤔 Update your VS Code settings with the new GitHub URL? (y/N): " update_settings
if [[ $update_settings =~ ^[Yy]$ ]]; then
    # Try to update VS Code settings
    SETTINGS_FILE="$HOME/AppData/Roaming/Code/User/settings.json"
    if [ -f "$SETTINGS_FILE" ]; then
        echo "⚙️ Updating VS Code settings..."
        # Create backup
        cp "$SETTINGS_FILE" "${SETTINGS_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
        
        # Update the GitHub URL in settings
        sed -i "s|git clone https://github.com/USERNAME/dev-methodology-templates.git|git clone https://github.com/$GITHUB_USER/$REPO_NAME.git|g" "$SETTINGS_FILE"
        echo "✅ VS Code settings updated!"
    else
        echo "⚠️ VS Code settings file not found at $SETTINGS_FILE"
        echo "💡 Manually update the GitHub URL in your VS Code Copilot instructions"
    fi
fi

echo ""
echo "🎉 Deployment complete! Your methodology is now globally accessible."