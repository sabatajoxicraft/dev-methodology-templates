#!/bin/bash

# 🎯 Universal Project Setup Script
# This script initializes any project with the portable development methodology
# Works in any environment: local, Codespaces, remote, containers

set -e

echo "🎯 Initializing Portable Development Methodology..."

# Detect environment
if [ -n "$CODESPACES" ]; then
    ENV_TYPE="codespaces"
elif [ -n "$REMOTE_CONTAINERS" ]; then
    ENV_TYPE="container"
elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    ENV_TYPE="remote"
else
    ENV_TYPE="local"
fi

echo "📍 Environment detected: $ENV_TYPE"

# Get project root
PROJECT_ROOT=$(pwd)
echo "📁 Project root: $PROJECT_ROOT"

# Create project memory if it doesn't exist
if [ ! -f "project_memory.md" ]; then
    echo "📝 Creating project_memory.md..."
    cp .methodology/templates/project_memory.md.template project_memory.md
    
    # Replace placeholders
    PROJECT_NAME=$(basename "$PROJECT_ROOT")
    sed -i "s/\${PROJECT_NAME}/$PROJECT_NAME/g" project_memory.md
    sed -i "s/\${DATE}/$(date '+%Y-%m-%d')/g" project_memory.md
    sed -i "s/\${ENVIRONMENT}/$ENV_TYPE/g" project_memory.md
fi

# Create docs folder structure
if [ ! -d "docs" ]; then
    echo "📚 Creating docs structure..."
    mkdir -p docs
    
    # Copy documentation templates
    cp -r .methodology/templates/docs/* docs/
    
    # Replace placeholders in docs
    find docs -name "*.md" -exec sed -i "s/\${PROJECT_NAME}/$(basename "$PROJECT_ROOT")/g" {} \;
    find docs -name "*.md" -exec sed -i "s/\${DATE}/$(date '+%Y-%m-%d')/g" {} \;
fi

# Create basic project structure
echo "🏗️ Setting up project structure..."

# Create src structure if it doesn't exist
if [ ! -d "src" ]; then
    mkdir -p src/{features,shared/{components,hooks,utils,types},assets}
fi

# Create VS Code configuration
echo "⚙️ Configuring VS Code..."
if [ ! -d ".vscode" ]; then
    mkdir -p .vscode
    cp .methodology/templates/vscode/* .vscode/
fi

# Create package.json if it doesn't exist (for JS/TS projects)
if [ ! -f "package.json" ] && ( [ -f "*.js" ] || [ -f "*.ts" ] || [ -f "*.jsx" ] || [ -f "*.tsx" ] ); then
    echo "📦 Creating package.json..."
    cp .methodology/templates/package.json.template package.json
    sed -i "s/\${PROJECT_NAME}/$(basename "$PROJECT_ROOT")/g" package.json
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "🚫 Creating .gitignore..."
    cp .methodology/templates/.gitignore.template .gitignore
fi

# Create README.md if it doesn't exist
if [ ! -f "README.md" ]; then
    echo "📖 Creating README.md..."
    cp .methodology/templates/README.md.template README.md
    sed -i "s/\${PROJECT_NAME}/$(basename "$PROJECT_ROOT")/g" README.md
fi

# Make automation scripts executable
echo "🔧 Setting up automation scripts..."
chmod +x .methodology/automation/*.sh

# Create project-specific automation symlinks
if [ ! -d "scripts" ]; then
    mkdir scripts
fi

ln -sf ../.methodology/automation/create-feature.sh scripts/create-feature
ln -sf ../.methodology/automation/create-component.sh scripts/create-component
ln -sf ../.methodology/automation/update-memory.sh scripts/update-memory

# Initialize git if not already a git repository
if [ ! -d ".git" ]; then
    echo "🔀 Initializing git repository..."
    git init
    git add .
    git commit -m "🎯 feat: initialize project with portable development methodology"
fi

# Environment-specific setup
case $ENV_TYPE in
    "codespaces")
        echo "☁️ Configuring for GitHub Codespaces..."
        # Add Codespaces-specific configurations
        if [ ! -f ".devcontainer/devcontainer.json" ]; then
            mkdir -p .devcontainer
            cp .methodology/templates/devcontainer.json .devcontainer/
        fi
        ;;
    "container")
        echo "🐳 Configuring for container environment..."
        # Add container-specific configurations
        ;;
    "remote")
        echo "🔗 Configuring for remote development..."
        # Add remote-specific configurations
        ;;
    "local")
        echo "💻 Configuring for local development..."
        # Add local-specific configurations
        ;;
esac

echo ""
echo "✅ Project initialized successfully!"
echo ""
echo "🎯 Next steps:"
echo "1. Review and update project_memory.md with your project goals"
echo "2. Check docs/ folder and customize architecture decisions"
echo "3. Start building with: scripts/create-feature <feature-name>"
echo "4. Create components with: scripts/create-component <ComponentName> <feature-name>"
echo ""
echo "📚 Quick reference:"
echo "- Project memory: project_memory.md"
echo "- Documentation: docs/"
echo "- Automation: scripts/"
echo "- Standards: .methodology/standards/"
echo ""
echo "🚀 Happy coding with portable methodology!"