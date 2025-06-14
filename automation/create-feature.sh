#!/bin/bash

# 🎯 Create Feature Script
# Creates a new feature with the proper structure and templates
# TECH-STACK AGNOSTIC: Works with any programming language or framework

set -e

if [ $# -eq 0 ]; then
    echo "❌ Usage: $0 <feature-name>"
    echo "📋 Example: $0 user-authentication"
    exit 1
fi

FEATURE_NAME=$1
FEATURE_DIR="src/features/${FEATURE_NAME}"

echo "🚀 Creating feature: ${FEATURE_NAME}"

# Check if feature already exists
if [ -d "$FEATURE_DIR" ]; then
    echo "❌ Feature ${FEATURE_NAME} already exists!"
    exit 1
fi

# Create feature directory structure
echo "📁 Creating directory structure..."
mkdir -p "$FEATURE_DIR"/{core,models,services,tests}

# Create feature README
PASCAL_CASE_NAME=$(echo "$FEATURE_NAME" | sed -r 's/(^|-)([a-z])/\U\2/g')
cat > "$FEATURE_DIR/README.md" << EOF
# ${PASCAL_CASE_NAME} Feature

## Overview
Brief description of what this feature does and its purpose.

## Structure
- **core/**: Main business logic and implementation
- **models/**: Data models, schemas, interfaces, or types
- **services/**: External integrations (APIs, databases, third-party services)
- **tests/**: Feature-specific tests

## Key Components
- List main modules and their responsibilities

## Data Models
- List key data structures and their purposes

## Services & Integrations
- List external services and APIs used

## Usage
\`\`\`
// Add usage examples appropriate for your technology stack
\`\`\`

## Testing
Run tests specific to this feature:
\`\`\`bash
# Add test commands appropriate for your stack
\`\`\`

## Dependencies
- List any feature-specific dependencies

## Configuration
- Document any configuration required for this feature
EOF

# Create core directory with example structure
cat > "$FEATURE_DIR/core/README.md" << EOF
# ${PASCAL_CASE_NAME} Core Logic

This directory contains the main business logic for the ${FEATURE_NAME} feature.

## Guidelines
- Keep business logic pure and testable
- Separate concerns into focused modules
- Follow your language's best practices for organization
- Document complex algorithms and business rules

## Structure
Organize files according to your technology stack:
- Single responsibility modules
- Clear interfaces/contracts
- Minimal external dependencies
EOF

# Create models directory
cat > "$FEATURE_DIR/models/README.md" << EOF
# ${PASCAL_CASE_NAME} Data Models

This directory contains data models, schemas, interfaces, or types for the ${FEATURE_NAME} feature.

## Guidelines
- Define clear data contracts
- Use appropriate validation
- Document field purposes and constraints
- Version your schemas when needed

## Examples
\`\`\`
// Add examples appropriate for your technology stack
// For TypeScript: interfaces and types
// For Python: Pydantic models or dataclasses
// For Go: structs with tags
// For Java: POJOs or records
\`\`\`
EOF

# Create services directory
cat > "$FEATURE_DIR/services/README.md" << EOF
# ${PASCAL_CASE_NAME} Services

This directory contains services for external integrations and business operations.

## Guidelines
- Separate external dependencies from core logic
- Implement proper error handling
- Use dependency injection patterns
- Include retry logic and timeouts where appropriate

## Types of Services
- **API clients**: External service integrations
- **Data access**: Database operations
- **Business services**: Complex operations that coordinate multiple sources
- **Validation services**: Data validation and sanitization
EOF

# Create tests directory
cat > "$FEATURE_DIR/tests/README.md" << EOF
# ${PASCAL_CASE_NAME} Tests

This directory contains tests specific to the ${FEATURE_NAME} feature.

## Test Organization
- **Unit tests**: Test individual modules and functions
- **Integration tests**: Test feature workflows and external integrations
- **Test data**: Mock data and fixtures

## Guidelines
- Test both happy path and error scenarios
- Mock external dependencies
- Use descriptive test names
- Maintain good test coverage

## Running Tests
\`\`\`bash
# Add commands specific to your testing framework
\`\`\`
EOF

# Update project memory
echo "📝 Updating project memory..."
DATE=$(date '+%Y-%m-%d %H:%M')
echo "" >> project_memory.md
echo "### ${DATE} - Created ${FEATURE_NAME} feature" >> project_memory.md
echo "- Created feature structure in ${FEATURE_DIR}" >> project_memory.md
echo "- Set up core, models, services, and tests directories" >> project_memory.md
echo "- Added documentation templates for each directory" >> project_memory.md
echo "" >> project_memory.md

echo "✅ Feature ${FEATURE_NAME} created successfully!"
echo ""
echo "📁 Structure created:"
echo "   ${FEATURE_DIR}/"
echo "   ├── core/           # Main business logic"
echo "   ├── models/         # Data models and schemas"
echo "   ├── services/       # External integrations"
echo "   ├── tests/          # Feature tests"
echo "   └── README.md       # Feature documentation"
echo ""
echo "🎯 Next steps:"
echo "1. Define your data models in ${FEATURE_DIR}/models/"
echo "2. Implement core business logic in ${FEATURE_DIR}/core/"
echo "3. Add external integrations in ${FEATURE_DIR}/services/"
echo "4. Write tests in ${FEATURE_DIR}/tests/"
echo "5. Update the feature README.md with specific details"
echo "6. Update project_memory.md with feature goals and plans"