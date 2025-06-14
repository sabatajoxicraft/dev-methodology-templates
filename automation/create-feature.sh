#!/bin/bash

# 🎯 Create Feature Script
# Creates a new feature with the proper structure and templates

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
mkdir -p "$FEATURE_DIR"/{components,hooks,services,types,__tests__}

# Create index.ts file
echo "📝 Creating feature index..."
cat > "$FEATURE_DIR/index.ts" << EOF
// Feature: ${FEATURE_NAME}
// Export all public components, hooks, and types

// Components
export * from './components';

// Hooks
export * from './hooks';

// Services
export * from './services';

// Types
export * from './types';
EOF

# Create component index
cat > "$FEATURE_DIR/components/index.ts" << EOF
// Export all components from this feature
EOF

# Create hooks index
cat > "$FEATURE_DIR/hooks/index.ts" << EOF
// Export all hooks from this feature
EOF

# Create services index
cat > "$FEATURE_DIR/services/index.ts" << EOF
// Export all services from this feature
EOF

# Create types file
PASCAL_CASE_NAME=$(echo "$FEATURE_NAME" | sed -r 's/(^|-)([a-z])/\U\2/g')
cat > "$FEATURE_DIR/types.ts" << EOF
// Types for ${FEATURE_NAME} feature

export interface ${PASCAL_CASE_NAME}State {
  // Define state interface
}

export interface ${PASCAL_CASE_NAME}Props {
  // Define props interface
}

export interface ${PASCAL_CASE_NAME}Data {
  // Define data interface
}

// Add more types as needed
EOF

# Create a basic README for the feature
cat > "$FEATURE_DIR/README.md" << EOF
# ${PASCAL_CASE_NAME} Feature

## Overview
Brief description of what this feature does.

## Components
- List main components

## Hooks
- List custom hooks

## Services
- List services and their purposes

## Types
- Key TypeScript interfaces and types

## Usage
\`\`\`typescript
import { SomeComponent } from '@/features/${FEATURE_NAME}';

<SomeComponent />
\`\`\`

## Testing
Run tests with:
\`\`\`bash
npm test -- ${FEATURE_NAME}
\`\`\`
EOF

# Update project memory
echo "📝 Updating project memory..."
DATE=$(date '+%Y-%m-%d %H:%M')
echo "" >> project_memory.md
echo "### ${DATE} - Created ${FEATURE_NAME} feature" >> project_memory.md
echo "- Created feature structure in ${FEATURE_DIR}" >> project_memory.md
echo "- Set up components, hooks, services, and types directories" >> project_memory.md
echo "" >> project_memory.md

echo "✅ Feature ${FEATURE_NAME} created successfully!"
echo ""
echo "📁 Structure created:"
echo "   ${FEATURE_DIR}/"
echo "   ├── components/"
echo "   ├── hooks/"
echo "   ├── services/"
echo "   ├── types.ts"
echo "   ├── __tests__/"
echo "   ├── index.ts"
echo "   └── README.md"
echo ""
echo "🎯 Next steps:"
echo "1. Create your first component: scripts/create-component <ComponentName> ${FEATURE_NAME}"
echo "2. Add types to ${FEATURE_DIR}/types.ts"
echo "3. Update the feature README.md with details"
echo "4. Update project_memory.md with feature goals and plans"