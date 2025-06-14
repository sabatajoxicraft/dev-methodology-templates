#!/bin/bash

# 🎯 Create Component Script
# Creates a new component with proper structure, tests, and stories

set -e

if [ $# -lt 2 ]; then
    echo "❌ Usage: $0 <ComponentName> <feature-name> [component-type]"
    echo "📋 Examples:"
    echo "   $0 UserProfile user-authentication"
    echo "   $0 LoginForm user-authentication form"
    echo "   $0 Button shared ui"
    exit 1
fi

COMPONENT_NAME=$1
FEATURE_NAME=$2
COMPONENT_TYPE=${3:-"component"}

# Determine the target directory
if [ "$FEATURE_NAME" = "shared" ]; then
    COMPONENT_DIR="src/shared/components"
else
    COMPONENT_DIR="src/features/${FEATURE_NAME}/components"
fi

FULL_COMPONENT_DIR="${COMPONENT_DIR}/${COMPONENT_NAME}"

echo "🚀 Creating component: ${COMPONENT_NAME} in ${FEATURE_NAME}"

# Check if component already exists
if [ -d "$FULL_COMPONENT_DIR" ]; then
    echo "❌ Component ${COMPONENT_NAME} already exists in ${FEATURE_NAME}!"
    exit 1
fi

# Check if feature exists (unless it's shared)
if [ "$FEATURE_NAME" != "shared" ] && [ ! -d "src/features/${FEATURE_NAME}" ]; then
    echo "❌ Feature ${FEATURE_NAME} doesn't exist!"
    echo "💡 Create it first with: scripts/create-feature ${FEATURE_NAME}"
    exit 1
fi

# Create component directory
echo "📁 Creating component directory..."
mkdir -p "$FULL_COMPONENT_DIR"

# Create main component file
echo "📝 Creating component file..."
cat > "${FULL_COMPONENT_DIR}/${COMPONENT_NAME}.tsx" << EOF
import React from 'react';
import './${COMPONENT_NAME}.scss';

export interface ${COMPONENT_NAME}Props {
  /** Component children */
  children?: React.ReactNode;
  /** Additional CSS class name */
  className?: string;
  /** Component variant */
  variant?: 'default' | 'primary' | 'secondary';
  /** Disabled state */
  disabled?: boolean;
}

/**
 * ${COMPONENT_NAME} component
 * 
 * @param props - Component props
 * @returns JSX element
 * 
 * @example
 * \`\`\`tsx
 * <${COMPONENT_NAME} variant="primary">
 *   Content here
 * </${COMPONENT_NAME}>
 * \`\`\`
 */
export const ${COMPONENT_NAME}: React.FC<${COMPONENT_NAME}Props> = ({
  children,
  className = '',
  variant = 'default',
  disabled = false,
  ...props
}) => {
  const cssClasses = [
    '${COMPONENT_NAME}',
    \`\${COMPONENT_NAME}--\${variant}\`,
    disabled && \`\${COMPONENT_NAME}--disabled\`,
    className
  ].filter(Boolean).join(' ');

  return (
    <div 
      className={cssClasses}
      {...props}
    >
      {children}
    </div>
  );
};

export default ${COMPONENT_NAME};
EOF

# Create SCSS file
echo "🎨 Creating styles file..."
cat > "${FULL_COMPONENT_DIR}/${COMPONENT_NAME}.scss" << EOF
.${COMPONENT_NAME} {
  // Base styles
  display: block;
  
  // Variants
  &--default {
    // Default variant styles
  }
  
  &--primary {
    // Primary variant styles
  }
  
  &--secondary {
    // Secondary variant styles
  }
  
  // States
  &--disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  
  // Responsive design
  @media (max-width: 768px) {
    // Mobile styles
  }
}
EOF

# Create test file
echo "🧪 Creating test file..."
cat > "${FULL_COMPONENT_DIR}/${COMPONENT_NAME}.test.tsx" << EOF
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom';
import { ${COMPONENT_NAME} } from './${COMPONENT_NAME}';

describe('${COMPONENT_NAME}', () => {
  describe('rendering', () => {
    it('should render with default props', () => {
      render(<${COMPONENT_NAME}>Test content</${COMPONENT_NAME}>);
      
      const component = screen.getByText('Test content');
      expect(component).toBeInTheDocument();
      expect(component).toHaveClass('${COMPONENT_NAME}');
      expect(component).toHaveClass('${COMPONENT_NAME}--default');
    });

    it('should render with custom className', () => {
      render(
        <${COMPONENT_NAME} className="custom-class">
          Test content
        </${COMPONENT_NAME}>
      );
      
      const component = screen.getByText('Test content');
      expect(component).toHaveClass('custom-class');
    });

    it('should render with different variants', () => {
      const { rerender } = render(
        <${COMPONENT_NAME} variant="primary">
          Test content
        </${COMPONENT_NAME}>
      );
      
      let component = screen.getByText('Test content');
      expect(component).toHaveClass('${COMPONENT_NAME}--primary');

      rerender(
        <${COMPONENT_NAME} variant="secondary">
          Test content
        </${COMPONENT_NAME}>
      );
      
      component = screen.getByText('Test content');
      expect(component).toHaveClass('${COMPONENT_NAME}--secondary');
    });
  });

  describe('states', () => {
    it('should handle disabled state', () => {
      render(
        <${COMPONENT_NAME} disabled>
          Test content
        </${COMPONENT_NAME}>
      );
      
      const component = screen.getByText('Test content');
      expect(component).toHaveClass('${COMPONENT_NAME}--disabled');
    });
  });

  describe('interactions', () => {
    it('should handle click events', () => {
      const handleClick = jest.fn();
      render(
        <${COMPONENT_NAME} onClick={handleClick}>
          Test content
        </${COMPONENT_NAME}>
      );
      
      const component = screen.getByText('Test content');
      fireEvent.click(component);
      
      expect(handleClick).toHaveBeenCalledTimes(1);
    });
  });

  describe('accessibility', () => {
    it('should be accessible', () => {
      render(<${COMPONENT_NAME}>Accessible content</${COMPONENT_NAME}>);
      
      const component = screen.getByText('Accessible content');
      expect(component).toBeInTheDocument();
      // Add more accessibility tests as needed
    });
  });
});
EOF

# Create Storybook story file
echo "📚 Creating Storybook story..."
cat > "${FULL_COMPONENT_DIR}/${COMPONENT_NAME}.stories.tsx" << EOF
import type { Meta, StoryObj } from '@storybook/react';
import { ${COMPONENT_NAME} } from './${COMPONENT_NAME}';

const meta: Meta<typeof ${COMPONENT_NAME}> = {
  title: '${FEATURE_NAME}/${COMPONENT_NAME}',
  component: ${COMPONENT_NAME},
  parameters: {
    layout: 'centered',
    docs: {
      description: {
        component: '${COMPONENT_NAME} component for ${FEATURE_NAME} feature.'
      }
    }
  },
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: { type: 'select' },
      options: ['default', 'primary', 'secondary']
    },
    disabled: {
      control: { type: 'boolean' }
    }
  }
};

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    children: 'Default ${COMPONENT_NAME}',
    variant: 'default'
  }
};

export const Primary: Story = {
  args: {
    children: 'Primary ${COMPONENT_NAME}',
    variant: 'primary'
  }
};

export const Secondary: Story = {
  args: {
    children: 'Secondary ${COMPONENT_NAME}',
    variant: 'secondary'
  }
};

export const Disabled: Story = {
  args: {
    children: 'Disabled ${COMPONENT_NAME}',
    disabled: true
  }
};

export const WithCustomClass: Story = {
  args: {
    children: 'Custom styled ${COMPONENT_NAME}',
    className: 'custom-styling'
  }
};
EOF

# Create component index file
cat > "${FULL_COMPONENT_DIR}/index.ts" << EOF
export { ${COMPONENT_NAME} } from './${COMPONENT_NAME}';
export type { ${COMPONENT_NAME}Props } from './${COMPONENT_NAME}';
EOF

# Update the feature's component index
if [ "$FEATURE_NAME" = "shared" ]; then
    COMPONENTS_INDEX="${COMPONENT_DIR}/index.ts"
else
    COMPONENTS_INDEX="src/features/${FEATURE_NAME}/components/index.ts"
fi

echo "📝 Updating component index..."
echo "export { ${COMPONENT_NAME} } from './${COMPONENT_NAME}';" >> "$COMPONENTS_INDEX"
echo "export type { ${COMPONENT_NAME}Props } from './${COMPONENT_NAME}';" >> "$COMPONENTS_INDEX"

# Update project memory
echo "📝 Updating project memory..."
DATE=$(date '+%Y-%m-%d %H:%M')
echo "" >> project_memory.md
echo "### ${DATE} - Created ${COMPONENT_NAME} component" >> project_memory.md
echo "- Added ${COMPONENT_NAME} to ${FEATURE_NAME} feature" >> project_memory.md
echo "- Created component with tests and Storybook story" >> project_memory.md
echo "- Type: ${COMPONENT_TYPE}" >> project_memory.md
echo "" >> project_memory.md

echo "✅ Component ${COMPONENT_NAME} created successfully!"
echo ""
echo "📁 Files created:"
echo "   ${FULL_COMPONENT_DIR}/"
echo "   ├── ${COMPONENT_NAME}.tsx"
echo "   ├── ${COMPONENT_NAME}.scss"
echo "   ├── ${COMPONENT_NAME}.test.tsx"
echo "   ├── ${COMPONENT_NAME}.stories.tsx"
echo "   └── index.ts"
echo ""
echo "🎯 Next steps:"
echo "1. Customize the component props and implementation"
echo "2. Update the SCSS styles for your design system"
echo "3. Add more test cases specific to your component behavior"
echo "4. Update the Storybook story with relevant examples"
echo "5. Import and use the component in your feature"