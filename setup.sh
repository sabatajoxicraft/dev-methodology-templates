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

# Create minimal, language-agnostic structure
if [ ! -d "src" ]; then
    mkdir -p src
    echo "# Source Code" > src/README.md
    echo "Organize your source code here according to your technology stack and project needs." >> src/README.md
fi

# Create tests directory (universal)
if [ ! -d "tests" ]; then
    mkdir -p tests
    echo "# Tests" > tests/README.md
    echo "Organize your tests here. Follow the testing patterns appropriate for your technology stack." >> tests/README.md
fi

# Create scripts directory (universal)
if [ ! -d "scripts" ]; then
    mkdir -p scripts
    echo "# Scripts" > scripts/README.md
    echo "Add build, deployment, and automation scripts here." >> scripts/README.md
fi

# Create VS Code configuration
echo "⚙️ Configuring VS Code..."
if [ ! -d ".vscode" ]; then
    mkdir -p .vscode
    cp .methodology/templates/vscode/* .vscode/
    
    # Add workspace-specific Copilot settings
    cat >> .vscode/settings.json << 'EOF'
{
  "chat.instructionsFilesLocations": [".github/instructions"],
  "chat.promptFilesLocations": [".github/prompts"]
}
EOF
fi

# Create GitHub Copilot instruction files structure
echo "🤖 Setting up Copilot instruction files..."
if [ ! -d ".github" ]; then
    mkdir -p .github/instructions
    mkdir -p .github/prompts
    
    # Copy prompt templates
    if [ -d ".methodology/templates/github/prompts" ]; then
        cp .methodology/templates/github/prompts/* .github/prompts/
    fi
    
    # Create main Copilot instructions file
    cat > .github/copilot-instructions.md << EOF
# ${PROJECT_NAME} - Copilot Instructions

## Project Context
This project follows the Portable Development Methodology. Always reference project_memory.md for current context and decisions.

## Development Principles
- **Tech-Stack Agnostic**: Adapt to any programming language or framework
- **Docs-First**: Check docs/ folder for project-specific guidelines
- **Feature-Based**: Organize code in src/features/[feature-name]/{core,models,services,tests}
- **Hierarchical Building**: Start with data models, then core logic, then integrations, then tests

## Code Generation Guidelines
- Follow the established patterns in the codebase
- Use appropriate language conventions and best practices
- Include comprehensive error handling and validation
- Write tests for all new functionality
- Document complex logic with inline comments
- Update project_memory.md for significant changes

## Quality Standards
- Single responsibility principle for all modules/functions
- Comprehensive test coverage for critical paths
- Clear, meaningful naming conventions
- Proper separation of concerns
- Performance and security considerations
EOF

    # Create specific instruction files
    cat > .github/instructions/methodology.instructions.md << EOF
---
description: "Core development methodology guidelines"
applyTo: "**"
---

# Development Methodology Instructions

## Project Structure
- Follow feature-based organization: src/features/[feature-name]/{core,models,services,tests}
- Keep related functionality together regardless of technology stack
- Use hierarchical building: data models → core logic → integrations → tests

## Quality Standards
- Single responsibility principle for all modules/functions
- Comprehensive error handling and validation
- Clear, meaningful naming conventions
- Proper separation of concerns
- Performance and security considerations

## Documentation
- Update project_memory.md for significant changes
- Use language-appropriate documentation standards
- Include inline comments for complex logic
- Maintain README.md with current usage examples
EOF

    cat > .github/instructions/testing.instructions.md << EOF
---
description: "Testing guidelines and patterns"
applyTo: "**/*test*/**"
---

# Testing Instructions

## Test Organization
- Unit tests: Test individual functions/modules in isolation
- Integration tests: Test feature workflows and external integrations
- Use descriptive test names: test_[what]_[when]_[expected]

## Test Patterns
- Follow AAA pattern: Arrange, Act, Assert
- Mock external dependencies appropriately
- Test both success and failure scenarios
- Include edge cases and boundary conditions

## Framework Guidelines
- Use appropriate testing framework for the technology stack
- Maintain consistent test structure across the project
- Ensure tests are independent and can run in any order
- Aim for high coverage of critical business logic
EOF

    cat > .github/instructions/security.instructions.md << EOF
---
description: "Security guidelines for code generation"
applyTo: "**"
---

# Security Instructions

## Input Validation
- Validate and sanitize all user inputs at entry points
- Use parameterized queries for database operations
- Implement proper input type checking and bounds validation
- Escape output appropriately for the context (HTML, SQL, etc.)

## Authentication & Authorization
- Implement proper authentication mechanisms
- Use role-based access control (RBAC) where appropriate
- Never store passwords in plain text
- Implement secure session management

## Error Handling
- Don't expose sensitive information in error messages
- Log security events appropriately (without sensitive data)
- Implement proper error boundaries and fallbacks
- Use consistent error response formats

## Dependencies & Configuration
- Keep dependencies updated and audit for vulnerabilities
- Use environment variables for sensitive configuration
- Implement rate limiting and request throttling
- Follow security best practices for the specific language/framework

## Data Protection
- Encrypt sensitive data at rest and in transit
- Implement proper data retention and deletion policies
- Use secure random number generation
- Follow GDPR/privacy regulations where applicable
EOF
fi

# Note: Technology-specific files (package.json, requirements.txt, etc.) 
# should be created manually based on your project's needs

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "🚫 Creating .gitignore..."
    cp .methodology/templates/.gitignore.template .gitignore
    
    # Add .methodology to gitignore to avoid embedded repository warning
    echo "" >> .gitignore
    echo "# Methodology templates (not part of project)" >> .gitignore
    echo ".methodology/" >> .gitignore
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
    
    # Add all files except .methodology (which is excluded by .gitignore)
    git add .
    
    # Check if .methodology was accidentally added and remove it
    if git ls-files | grep -q "^\.methodology"; then
        echo "🔧 Removing .methodology from git tracking..."
        git rm -r --cached .methodology 2>/dev/null || true
        git add .gitignore
    fi
    
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