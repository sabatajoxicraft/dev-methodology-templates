# Style Guide - ${PROJECT_NAME}

**Last Updated**: ${DATE}

## 🎨 Universal Code Style Conventions

### Naming Conventions

#### General Principles (Adapt to Your Language)
- **Functions/Methods**: Use descriptive verbs (`getUserData`, `calculateTotal`, `validateInput`)
- **Variables**: Use clear nouns (`userName`, `totalAmount`, `validationResult`)
- **Constants**: Use UPPER_CASE (`API_BASE_URL`, `MAX_RETRY_ATTEMPTS`)
- **Classes/Types**: Use PascalCase (`UserProfile`, `DatabaseConnection`)
- **Files/Modules**: Use consistent casing per language convention

#### Language-Specific Examples

**JavaScript/TypeScript**
```javascript
// Variables & Functions: camelCase
const userName = 'john_doe';
function getUserData() { }

// Classes & Types: PascalCase
class UserService { }
interface ApiResponse { }

// Constants: UPPER_SNAKE_CASE
const API_BASE_URL = 'https://api.example.com';
```

**Python**
```python
# Variables & Functions: snake_case
user_name = 'john_doe'
def get_user_data():
    pass

# Classes: PascalCase
class UserService:
    pass

# Constants: UPPER_SNAKE_CASE
API_BASE_URL = 'https://api.example.com'
```

**Go**
```go
// Public: PascalCase, Private: camelCase
var UserName string
var apiBaseURL string

func GetUserData() { }
func validateInput() { }

type UserService struct { }
```

**Java**
```java
// Variables & Methods: camelCase
String userName = "john_doe";
public void getUserData() { }

// Classes: PascalCase
public class UserService { }

// Constants: UPPER_SNAKE_CASE
public static final String API_BASE_URL = "https://api.example.com";
```

### File and Directory Naming

#### Feature-Based Structure
```
src/features/user-authentication/
├── core/                    # Main business logic
├── models/                  # Data structures
├── services/                # External integrations
├── tests/                   # Feature tests
└── README.md               # Feature documentation
```

#### File Naming Conventions
- Use language-appropriate naming (kebab-case, snake_case, or PascalCase)
- Be descriptive and specific (`user_service.py`, `UserService.java`)
- Include purpose in name (`user.model.js`, `auth.service.go`)

## 📝 Documentation Standards

### Function/Method Documentation

**JavaScript/TypeScript (JSDoc)**
```typescript
/**
 * Formats a date string according to the specified locale and options.
 * 
 * @param date - The date to format (Date object or ISO string)
 * @param locale - The locale to use for formatting
 * @param options - Formatting options
 * @returns The formatted date string
 * 
 * @example
 * ```typescript
 * const formatted = formatDate(new Date(), 'en-US');
 * ```
 */
export const formatDate = (date: Date | string, locale: string = 'en-US'): string => {
  // Implementation
};
```

**Python (Docstrings)**
```python
def format_date(date_obj, locale='en-US'):
    """
    Format a date string according to the specified locale.
    
    Args:
        date_obj: The date to format (datetime object or string)
        locale: The locale to use for formatting
        
    Returns:
        str: The formatted date string
        
    Example:
        >>> format_date(datetime.now(), 'en-US')
        'January 15, 2024'
    """
    # Implementation
    pass
```

**Go (Comments)**
```go
// FormatDate formats a date string according to the specified locale.
// It takes a time.Time object and a locale string, returning a formatted string.
//
// Example:
//   formatted := FormatDate(time.Now(), "en-US")
func FormatDate(date time.Time, locale string) string {
    // Implementation
}
```

### Class/Module Documentation

#### Always Include
- **Purpose**: What this module does
- **Dependencies**: What it depends on
- **Usage**: How to use it
- **Examples**: Code examples
- **Notes**: Important implementation details

## 🧪 Testing Conventions

### Test Organization
```
tests/
├── unit/                   # Unit tests
├── integration/           # Integration tests
├── fixtures/              # Test data
└── helpers/               # Test utilities
```

### Test Naming Conventions

**Descriptive Test Names**
- Format: `test_[what]_[when]_[expected]`
- Examples:
  - `test_user_login_with_valid_credentials_succeeds`
  - `test_api_request_with_invalid_token_returns_401`
  - `test_calculation_with_zero_input_returns_zero`

**Test Structure (Universal Pattern)**
```
// Arrange - Set up test data and conditions
// Act - Execute the code being tested
// Assert - Verify the results
```

### Language-Specific Test Examples

**JavaScript/TypeScript (Jest)**
```typescript
describe('UserService', () => {
  describe('getUserById', () => {
    it('should return user when valid ID is provided', async () => {
      // Arrange
      const userId = '123';
      const expectedUser = { id: '123', name: 'John' };
      
      // Act
      const result = await userService.getUserById(userId);
      
      // Assert
      expect(result).toEqual(expectedUser);
    });
  });
});
```

**Python (unittest)**
```python
class TestUserService(unittest.TestCase):
    def test_get_user_by_id_with_valid_id_returns_user(self):
        # Arrange
        user_id = '123'
        expected_user = {'id': '123', 'name': 'John'}
        
        # Act
        result = self.user_service.get_user_by_id(user_id)
        
        # Assert
        self.assertEqual(result, expected_user)
```

## 🔄 Git Conventions

### Commit Message Format
```
type(scope): description

Examples:
feat(auth): add password reset functionality
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
refactor(api): simplify user validation
test(user): add unit tests for user service
chore(deps): update dependencies
```

### Commit Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Branch Naming
```
type/short-description

Examples:
feature/user-authentication
fix/login-validation-error
docs/api-documentation-update
refactor/database-connection-pool
```

## 📁 Code Organization

### Feature-Based Structure (Universal)
```
src/features/[feature-name]/
├── core/                   # Business logic
├── models/                 # Data structures
├── services/               # External integrations
├── tests/                  # Feature-specific tests
└── README.md              # Feature documentation
```

### Shared Code Organization
```
src/shared/
├── utils/                  # Utility functions
├── models/                 # Common data structures
├── services/               # Shared services
├── config/                 # Configuration
└── constants/              # Application constants
```

## 🎯 Best Practices

### Error Handling
- Always handle potential errors explicitly
- Provide meaningful error messages
- Log errors with appropriate context
- Implement graceful degradation

**Examples:**
```typescript
// TypeScript
try {
  const result = await riskyOperation();
  return result;
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new Error('Unable to complete operation');
}
```

```python
# Python
try:
    result = risky_operation()
    return result
except Exception as e:
    logger.error(f"Operation failed: {e}")
    raise ValueError("Unable to complete operation")
```

### Performance Considerations
- Profile before optimizing
- Use appropriate data structures
- Implement caching where beneficial
- Monitor resource usage

### Security Guidelines
- Validate all inputs
- Sanitize outputs
- Use parameterized queries
- Implement proper authentication/authorization
- Keep dependencies updated

### Code Reviews
- Review for logic correctness
- Check for security vulnerabilities
- Ensure proper error handling
- Verify test coverage
- Confirm documentation is updated

---

*This style guide should be adapted to your specific technology stack and updated as the project evolves. Follow language-specific conventions while maintaining these universal principles.*