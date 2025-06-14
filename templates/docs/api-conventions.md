# Interface & API Conventions - ${PROJECT_NAME}

**Last Updated**: ${DATE}

## 🔗 API Design Principles

### General Guidelines
- **Consistency**: Maintain consistent patterns across all interfaces
- **Simplicity**: Design intuitive and easy-to-use interfaces
- **Documentation**: Thoroughly document all public interfaces
- **Versioning**: Plan for interface evolution and backward compatibility

### Interface Types
- **HTTP APIs**: RESTful or GraphQL APIs
- **Library APIs**: Function/method interfaces for libraries
- **Database Interfaces**: Data access patterns and schemas
- **Event Interfaces**: Message and event schemas

## 🌐 HTTP API Conventions (if applicable)

### RESTful Design Patterns

#### Resource Naming
- Use plural nouns for collections: `/users`, `/orders`, `/products`
- Use singular nouns for single resources: `/user/123`, `/order/456`
- Use consistent casing: `kebab-case` or `snake_case`

#### HTTP Methods & Status Codes
```
GET    /resources          → 200 OK (list)
GET    /resources/123      → 200 OK (single), 404 Not Found
POST   /resources          → 201 Created, 400 Bad Request
PUT    /resources/123      → 200 OK, 404 Not Found
PATCH  /resources/123      → 200 OK, 404 Not Found
DELETE /resources/123      → 204 No Content, 404 Not Found
```

#### Response Format Standards
```json
{
  "success": true,
  "data": {
    "id": 123,
    "name": "Resource Name",
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z",
    "version": "1.0"
  }
}
```

#### Error Response Format
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable error description",
    "details": [
      {
        "field": "email",
        "message": "Email is required"
      }
    ]
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z",
    "requestId": "req_123456789"
  }
}
```

### Query Parameters
```
# Filtering
GET /users?status=active&role=admin

# Sorting
GET /users?sort=name:asc,createdAt:desc

# Pagination
GET /users?page=2&limit=20
GET /users?offset=20&limit=20

# Field Selection
GET /users?fields=id,name,email

# Search
GET /users?search=john&q=developer
```

## 📚 Library/Module Interface Design

### Function/Method Design

#### Naming Conventions
```python
# Python example
def get_user_by_id(user_id: int) -> Optional[User]:
    """Retrieve a user by their ID."""
    pass

def create_user(user_data: UserCreateData) -> User:
    """Create a new user with the provided data."""
    pass

def update_user(user_id: int, updates: UserUpdateData) -> User:
    """Update an existing user with partial data."""
    pass
```

```typescript
// TypeScript example
interface UserService {
  getUserById(userId: string): Promise<User | null>;
  createUser(userData: UserCreateData): Promise<User>;
  updateUser(userId: string, updates: Partial<User>): Promise<User>;
  deleteUser(userId: string): Promise<void>;
}
```

#### Parameter Design
- **Required parameters first**: Place mandatory parameters before optional ones
- **Use descriptive names**: Avoid abbreviations and single letters
- **Group related parameters**: Use objects/structs for related data
- **Provide defaults**: Sensible default values for optional parameters

```go
// Go example
type UserSearchOptions struct {
    Status   string
    Role     string
    Page     int
    PageSize int
}

func SearchUsers(query string, options UserSearchOptions) ([]User, error) {
    // Implementation
}
```

#### Return Value Design
- **Consistent return types**: Use similar patterns across similar functions
- **Error handling**: Clear error reporting mechanisms
- **Null/empty handling**: Consistent handling of missing or empty data

```java
// Java example
public class UserService {
    public Optional<User> findUserById(String userId) {
        // Returns empty Optional if not found
    }
    
    public Result<User, ValidationError> createUser(UserData userData) {
        // Returns either success with User or error with details
    }
}
```

## 📊 Data Interface Conventions

### Data Transfer Objects (DTOs)
```typescript
// Input DTOs - for receiving data
interface CreateUserRequest {
  name: string;
  email: string;
  password: string;
  role?: UserRole;
}

// Output DTOs - for sending data
interface UserResponse {
  id: string;
  name: string;
  email: string;
  role: UserRole;
  createdAt: string;
  updatedAt: string;
}

// Update DTOs - for partial updates
interface UpdateUserRequest {
  name?: string;
  email?: string;
  role?: UserRole;
}
```

### Data Validation
```python
# Python with Pydantic example
from pydantic import BaseModel, EmailStr, validator

class UserCreateRequest(BaseModel):
    name: str
    email: EmailStr
    password: str
    
    @validator('password')
    def validate_password(cls, v):
        if len(v) < 8:
            raise ValueError('Password must be at least 8 characters')
        return v
```

## 🔄 Event & Message Interfaces

### Event Schema Design
```json
{
  "eventType": "user.created",
  "eventId": "evt_123456789",
  "timestamp": "2024-01-15T10:30:00Z",
  "version": "1.0",
  "source": "user-service",
  "data": {
    "userId": "123",
    "userName": "John Doe",
    "userEmail": "john@example.com"
  },
  "metadata": {
    "correlationId": "corr_987654321",
    "causationId": "cause_456789123"
  }
}
```

### Message Queue Conventions
```
# Topic/Queue naming
user.events          # User-related events
order.commands        # Order processing commands
notification.requests # Notification requests

# Message types
user.created         # Domain events
user.updated
order.process        # Commands
email.send          # Requests
```

## 🔐 Authentication & Authorization

### Authentication Patterns
```http
# Bearer Token
Authorization: Bearer <jwt_token>

# API Key
X-API-Key: <api_key>

# Basic Authentication (dev/testing only)
Authorization: Basic <base64_credentials>
```

### Permission Models
```typescript
interface User {
  id: string;
  permissions: Permission[];
  roles: Role[];
}

interface Permission {
  resource: string;    // 'users', 'orders', 'reports'
  action: string;      // 'read', 'write', 'delete'
  scope?: string;      // 'own', 'team', 'all'
}
```

## 📋 Documentation Standards

### Interface Documentation Template
```markdown
## Function: createUser

**Purpose**: Creates a new user in the system

**Parameters**:
- `userData` (UserCreateData): User information
  - `name` (string, required): Full name
  - `email` (string, required): Valid email address
  - `password` (string, required): Min 8 characters

**Returns**: 
- `Promise<User>`: Created user object
- Throws `ValidationError` for invalid input
- Throws `ConflictError` if email already exists

**Example**:
```typescript
const user = await createUser({
  name: "John Doe",
  email: "john@example.com",
  password: "securePassword123"
});
```

**Error Handling**:
- Validates email format
- Checks password strength
- Ensures email uniqueness
```

### API Endpoint Documentation
```markdown
## POST /api/v1/users

**Description**: Create a new user account

**Request Body**:
```json
{
  "name": "string (required)",
  "email": "string (required, email format)",
  "password": "string (required, min 8 chars)"
}
```

**Responses**:
- `201 Created`: User successfully created
- `400 Bad Request`: Invalid input data
- `409 Conflict`: Email already exists
- `422 Unprocessable Entity`: Validation errors

**Example Request**:
```bash
curl -X POST https://api.example.com/v1/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com","password":"secret123"}'
```
```

## 🧪 Testing Interface Contracts

### Contract Testing
```typescript
// API contract tests
describe('User API Contract', () => {
  it('should return user with correct schema', async () => {
    const response = await api.get('/users/123');
    
    expect(response.data).toMatchSchema({
      type: 'object',
      properties: {
        id: { type: 'string' },
        name: { type: 'string' },
        email: { type: 'string', format: 'email' }
      },
      required: ['id', 'name', 'email']
    });
  });
});
```

### Mock Interfaces
```python
# Python testing with mocks
from unittest.mock import Mock

def test_user_service():
    # Mock external dependencies
    mock_database = Mock()
    mock_database.find_user.return_value = User(id=1, name="Test")
    
    service = UserService(database=mock_database)
    user = service.get_user_by_id(1)
    
    assert user.name == "Test"
    mock_database.find_user.assert_called_once_with(1)
```

## 🔧 Versioning & Evolution

### Interface Versioning
```
# URL versioning
/api/v1/users
/api/v2/users

# Header versioning
Accept: application/vnd.api+json; version=1
API-Version: 2024-01-15
```

### Backward Compatibility
- **Additive changes**: New optional fields/parameters
- **Deprecation process**: Clear timeline and migration path
- **Breaking changes**: Major version increments only

### Change Documentation
```markdown
## API Changelog

### v2.1.0 (2024-01-15)
**Added**:
- New optional field `profileImage` in User response
- Query parameter `includeInactive` for user listing

**Deprecated**:
- Field `avatar` in User response (use `profileImage` instead)

### v2.0.0 (2024-01-01)
**Breaking Changes**:
- Removed deprecated `username` field from User
- Changed date format from Unix timestamp to ISO 8601
```

---

*These interface conventions ensure consistency, usability, and maintainability across all system boundaries.*