# Universal Coding Standards

**Last Updated**: 2025-01-15

## 🎯 Core Principles

### Code Quality Standards
- **Readability**: Code should be self-documenting and easy to understand
- **Consistency**: Follow established patterns throughout the project
- **Simplicity**: Prefer simple, clear solutions over complex ones
- **Maintainability**: Write code that's easy to modify and extend
- **Testability**: Design code to be easily testable

### SOLID Principles (Object-Oriented Languages)
- **S**ingle Responsibility: Each class/module has one reason to change
- **O**pen/Closed: Open for extension, closed for modification
- **L**iskov Substitution: Subtypes must be substitutable for their base types
- **I**nterface Segregation: Depend on abstractions, not concretions
- **D**ependency Inversion: High-level modules shouldn't depend on low-level modules

## 📝 Naming Conventions

### Universal Guidelines
- Use descriptive, meaningful names
- Avoid abbreviations and single-letter variables (except for loop counters)
- Be consistent within your language's conventions
- Use verbs for functions/methods, nouns for variables/classes

### Language-Specific Examples

#### JavaScript/TypeScript
```javascript
// Variables & Functions: camelCase
const userName = 'john_doe';
const getUserData = () => {};

// Classes & Interfaces: PascalCase
class UserService {}
interface ApiResponse {}

// Constants: UPPER_SNAKE_CASE
const API_BASE_URL = 'https://api.example.com';
```

#### Python
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

#### Java
```java
// Variables & Methods: camelCase
String userName = "john_doe";
public void getUserData() {}

// Classes: PascalCase
public class UserService {}

// Constants: UPPER_SNAKE_CASE
public static final String API_BASE_URL = "https://api.example.com";
```

#### Go
```go
// Public: PascalCase, Private: camelCase
var UserName string
var apiBaseURL string

func GetUserData() {}
func validateInput() {}

type UserService struct {}
```

## 🏗️ Code Structure

### Function/Method Design
- **Single responsibility**: Each function should do one thing well
- **Short functions**: Aim for functions under 20-30 lines
- **Clear parameters**: Use descriptive parameter names
- **Return early**: Reduce nesting with early returns

```python
# Good
def calculate_discount(price, customer_type):
    if price <= 0:
        return 0
    
    if customer_type == 'premium':
        return price * 0.2
    elif customer_type == 'regular':
        return price * 0.1
    
    return 0

# Bad
def calculate_discount(price, customer_type):
    discount = 0
    if price > 0:
        if customer_type == 'premium':
            discount = price * 0.2
        else:
            if customer_type == 'regular':
                discount = price * 0.1
    return discount
```

### Class Design (OOP Languages)
- **Encapsulation**: Keep data private, expose through methods
- **Small classes**: Focus on single responsibility
- **Composition over inheritance**: Prefer composition when possible
- **Interface segregation**: Create focused interfaces

```typescript
// Good
interface UserRepository {
  findById(id: string): Promise<User | null>;
  save(user: User): Promise<User>;
}

interface UserNotifier {
  sendWelcomeEmail(user: User): Promise<void>;
}

class UserService {
  constructor(
    private userRepository: UserRepository,
    private notifier: UserNotifier
  ) {}
  
  async createUser(userData: CreateUserData): Promise<User> {
    const user = new User(userData);
    const savedUser = await this.userRepository.save(user);
    await this.notifier.sendWelcomeEmail(savedUser);
    return savedUser;
  }
}
```

## 📚 Documentation Standards

### Code Comments
- **When to comment**: Explain why, not what
- **Complex logic**: Document algorithms and business rules
- **Public APIs**: Document all public interfaces
- **TODOs**: Use TODO comments for future improvements

```python
def calculate_shipping_cost(weight, distance, priority):
    """
    Calculate shipping cost based on weight, distance, and priority.
    
    Uses a complex algorithm that factors in fuel costs, driver availability,
    and dynamic pricing based on demand.
    
    Args:
        weight: Package weight in kg
        distance: Shipping distance in km
        priority: 'standard', 'express', or 'overnight'
    
    Returns:
        Shipping cost in currency units
    """
    # Base cost calculation uses industry-standard formula
    base_cost = (weight * 0.5) + (distance * 0.1)
    
    # Apply priority multiplier based on service level
    priority_multipliers = {
        'standard': 1.0,
        'express': 1.5,
        'overnight': 2.0
    }
    
    return base_cost * priority_multipliers.get(priority, 1.0)
```

### Function Documentation

#### JavaScript/TypeScript (JSDoc)
```typescript
/**
 * Formats a date according to locale and options.
 * 
 * @param date - The date to format
 * @param locale - Locale for formatting (default: 'en-US')
 * @param options - Intl.DateTimeFormatOptions
 * @returns Formatted date string
 * 
 * @example
 * ```typescript
 * formatDate(new Date(), 'en-US', { year: 'numeric' });
 * ```
 */
export const formatDate = (
  date: Date,
  locale: string = 'en-US',
  options?: Intl.DateTimeFormatOptions
): string => {
  // Implementation
};
```

#### Python (Docstrings)
```python
def format_date(date_obj, locale='en-US'):
    """
    Format a date according to locale and options.
    
    Args:
        date_obj (datetime): The date to format
        locale (str): Locale for formatting (default: 'en-US')
        
    Returns:
        str: Formatted date string
        
    Raises:
        ValueError: If date_obj is invalid
        
    Example:
        >>> format_date(datetime.now(), 'en-US')
        'January 15, 2024'
    """
    # Implementation
    pass
```

## 🧪 Testing Standards

### Test Organization
```
tests/
├── unit/              # Unit tests
├── integration/       # Integration tests
├── fixtures/          # Test data
└── helpers/          # Test utilities
```

### Test Naming
- **Descriptive names**: `test_user_creation_with_valid_email_succeeds`
- **Follow pattern**: `test_[what]_[when]_[expected_result]`
- **Group related tests**: Use test classes or describe blocks

### Test Structure (AAA Pattern)
```python
def test_user_service_create_user_with_valid_data_returns_user():
    # Arrange
    user_data = {
        'name': 'John Doe',
        'email': 'john@example.com'
    }
    user_service = UserService()
    
    # Act
    result = user_service.create_user(user_data)
    
    # Assert
    assert result.name == 'John Doe'
    assert result.email == 'john@example.com'
    assert result.id is not None
```

### Mocking and Test Doubles
```typescript
// Jest example
describe('UserService', () => {
  it('should call repository when creating user', async () => {
    // Arrange
    const mockRepository = {
      save: jest.fn().mockResolvedValue({ id: '123', name: 'John' })
    };
    const userService = new UserService(mockRepository);
    
    // Act
    await userService.createUser({ name: 'John' });
    
    // Assert
    expect(mockRepository.save).toHaveBeenCalledWith({ name: 'John' });
  });
});
```

## 🚨 Error Handling

### Error Handling Patterns

#### Try-Catch Blocks
```typescript
async function fetchUserData(userId: string): Promise<User> {
  try {
    const response = await api.get(`/users/${userId}`);
    return response.data;
  } catch (error) {
    if (error.response?.status === 404) {
      throw new UserNotFoundError(`User ${userId} not found`);
    }
    throw new ServiceError('Failed to fetch user data', error);
  }
}
```

#### Result Pattern (Functional Approach)
```typescript
type Result<T, E = Error> = 
  | { success: true; data: T }
  | { success: false; error: E };

async function fetchUser(id: string): Promise<Result<User, string>> {
  try {
    const user = await userRepository.findById(id);
    return { success: true, data: user };
  } catch (error) {
    return { success: false, error: error.message };
  }
}
```

### Error Types
- **Domain errors**: Business rule violations
- **Validation errors**: Input validation failures
- **Infrastructure errors**: Database, network, file system errors
- **Configuration errors**: Missing or invalid configuration

## 🔧 Code Quality Tools

### Static Analysis
- **Linters**: ESLint (JS/TS), Pylint (Python), golint (Go)
- **Type checkers**: TypeScript, mypy (Python)
- **Code formatters**: Prettier (JS/TS), Black (Python), gofmt (Go)

### Code Metrics
- **Cyclomatic complexity**: Measure code complexity
- **Test coverage**: Aim for 80%+ on critical paths
- **Code duplication**: Minimize repeated code
- **Technical debt**: Track and address regularly

### Example Configuration (.editorconfig)
```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.{js,ts,py,go,java}]
indent_style = space
indent_size = 2

[*.py]
indent_size = 4

[*.go]
indent_style = tab
```

## 🔄 Code Review Guidelines

### What to Look For
- **Correctness**: Does the code work as intended?
- **Readability**: Is the code easy to understand?
- **Performance**: Are there obvious performance issues?
- **Security**: Are there security vulnerabilities?
- **Tests**: Is the code adequately tested?

### Review Checklist
- [ ] Code follows project naming conventions
- [ ] Functions are single-purpose and reasonably sized
- [ ] Error handling is appropriate
- [ ] Code is well-documented
- [ ] Tests cover the main functionality
- [ ] No obvious security issues
- [ ] Performance considerations addressed

---

*These standards should be adapted to your specific technology stack while maintaining the core principles of clean, maintainable code.*