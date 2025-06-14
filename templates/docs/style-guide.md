# Style Guide - ${PROJECT_NAME}

**Last Updated**: ${DATE}

## 🎨 Code Style Conventions

### TypeScript/JavaScript

#### Naming Conventions
- **Variables & Functions**: camelCase (`getUserData`, `isLoggedIn`)
- **Constants**: UPPER_SNAKE_CASE (`API_BASE_URL`, `MAX_RETRY_ATTEMPTS`)
- **Classes & Components**: PascalCase (`UserProfile`, `ApiService`)
- **Interfaces**: PascalCase with 'I' prefix (`IUserData`, `IApiResponse`)
- **Types**: PascalCase (`UserRole`, `ComponentProps`)
- **Enums**: PascalCase (`UserStatus`, `HttpMethod`)

#### File Naming
- **Components**: PascalCase (`UserProfile.tsx`, `LoginForm.tsx`)
- **Hooks**: camelCase with 'use' prefix (`useAuth.ts`, `useApi.ts`)
- **Utils**: camelCase (`formatDate.ts`, `validation.ts`)
- **Types**: camelCase (`user.types.ts`, `api.types.ts`)
- **Constants**: camelCase (`constants.ts`, `config.ts`)

#### Code Structure
```typescript
// 1. Imports (external libraries first, then internal)
import React from 'react';
import { useState } from 'react';

import { Button } from '@/shared/components';
import { useAuth } from '@/features/auth/hooks';

// 2. Types and interfaces
interface Props {
  title: string;
  onSubmit: () => void;
}

// 3. Component definition
export const MyComponent: React.FC<Props> = ({ title, onSubmit }) => {
  // 4. Hooks
  const { user } = useAuth();
  const [loading, setLoading] = useState(false);

  // 5. Functions
  const handleSubmit = () => {
    // Implementation
  };

  // 6. Render
  return (
    <div>
      {/* JSX content */}
    </div>
  );
};
```

### CSS/SCSS

#### Class Naming (BEM-inspired)
```css
/* Block */
.user-card { }

/* Element */
.user-card__title { }
.user-card__content { }

/* Modifier */
.user-card--premium { }
.user-card__title--large { }
```

#### Property Order
1. Layout properties (display, position, etc.)
2. Box model (width, height, margin, padding)
3. Typography (font-family, font-size, etc.)
4. Visual (color, background, border)
5. Misc (cursor, z-index, etc.)

```css
.component {
  /* Layout */
  display: flex;
  position: relative;
  
  /* Box Model */
  width: 100%;
  height: auto;
  margin: 1rem 0;
  padding: 1rem;
  
  /* Typography */
  font-family: 'Inter', sans-serif;
  font-size: 1rem;
  line-height: 1.5;
  
  /* Visual */
  color: #333;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  
  /* Misc */
  cursor: pointer;
  z-index: 1;
}
```

## 📝 Documentation Standards

### JSDoc Comments
```typescript
/**
 * Formats a date string according to the specified locale and options.
 * 
 * @param date - The date to format (Date object or ISO string)
 * @param locale - The locale to use for formatting (default: 'en-US')
 * @param options - Intl.DateTimeFormatOptions for customization
 * @returns The formatted date string
 * 
 * @example
 * ```typescript
 * const formatted = formatDate(new Date(), 'en-US', { 
 *   year: 'numeric', 
 *   month: 'long', 
 *   day: 'numeric' 
 * });
 * // Returns: "January 15, 2024"
 * ```
 */
export const formatDate = (
  date: Date | string,
  locale: string = 'en-US',
  options?: Intl.DateTimeFormatOptions
): string => {
  // Implementation
};
```

### Component Documentation
```typescript
/**
 * A reusable button component with multiple variants and states.
 * 
 * @example
 * ```tsx
 * <Button 
 *   variant="primary" 
 *   size="large" 
 *   loading={isSubmitting}
 *   onClick={handleSubmit}
 * >
 *   Submit Form
 * </Button>
 * ```
 */
interface ButtonProps {
  /** The button text or content */
  children: React.ReactNode;
  /** Button style variant */
  variant?: 'primary' | 'secondary' | 'danger';
  /** Button size */
  size?: 'small' | 'medium' | 'large';
  /** Whether the button is in loading state */
  loading?: boolean;
  /** Click handler */
  onClick?: () => void;
}
```

## 🧪 Testing Conventions

### Test File Structure
```typescript
// UserProfile.test.tsx
describe('UserProfile', () => {
  describe('rendering', () => {
    it('should display user name when provided', () => {
      // Test implementation
    });

    it('should show loading state when data is loading', () => {
      // Test implementation
    });
  });

  describe('interactions', () => {
    it('should call onEdit when edit button is clicked', () => {
      // Test implementation
    });
  });

  describe('edge cases', () => {
    it('should handle missing user data gracefully', () => {
      // Test implementation
    });
  });
});
```

### Test Naming
- **Describe blocks**: Use the component/function name being tested
- **Test cases**: Use "should [expected behavior] when [condition]"

## 🔄 Git Conventions

### Commit Messages
Follow conventional commit format:
```
type(scope): description

feat(auth): add password reset functionality
fix(ui): resolve button alignment issue in mobile view
docs(readme): update installation instructions
refactor(api): simplify user data validation
test(user): add unit tests for user service
chore(deps): update typescript to v5.0
```

### Branch Naming
```
feature/user-authentication
fix/button-alignment-mobile
docs/update-readme
refactor/api-validation
```

## 📁 File Organization

### Feature Structure
```
src/features/user-profile/
├── components/
│   ├── UserProfile.tsx
│   ├── UserProfile.test.tsx
│   ├── UserProfile.stories.tsx
│   └── index.ts
├── hooks/
│   ├── useUserProfile.ts
│   ├── useUserProfile.test.ts
│   └── index.ts
├── services/
│   ├── userProfileService.ts
│   ├── userProfileService.test.ts
│   └── index.ts
├── types.ts
└── index.ts
```

### Import/Export Conventions
```typescript
// Always use named exports for components
export const UserProfile: React.FC<Props> = () => { };

// Use default exports only for page components
export default UserProfilePage;

// Barrel exports in index.ts files
export { UserProfile } from './UserProfile';
export { useUserProfile } from './useUserProfile';
export type { UserProfileProps } from './types';
```

## 🎯 Best Practices

### Performance
- Use React.memo for components that re-render frequently
- Implement proper dependency arrays in useEffect
- Avoid inline object/function creation in render
- Use lazy loading for large components

### Accessibility
- Always include alt text for images
- Use semantic HTML elements
- Implement proper ARIA labels
- Ensure keyboard navigation works
- Maintain sufficient color contrast

### Error Handling
- Always handle async operations with try/catch
- Provide meaningful error messages to users
- Log errors for debugging purposes
- Implement graceful degradation

---

*This style guide should be followed consistently across the project and updated as the project evolves.*