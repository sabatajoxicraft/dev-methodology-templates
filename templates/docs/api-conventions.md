# API Conventions - ${PROJECT_NAME}

**Last Updated**: ${DATE}

## 🔗 RESTful API Design

### Base URL Structure
```
https://api.${PROJECT_NAME}.com/v1/
```

### HTTP Methods
- **GET**: Retrieve data
- **POST**: Create new resources
- **PUT**: Update entire resource
- **PATCH**: Partial resource update
- **DELETE**: Remove resource

### Resource Naming
- Use plural nouns for collections: `/users`, `/posts`, `/comments`
- Use singular nouns for single resources: `/user/123`, `/post/456`
- Use kebab-case for multi-word resources: `/user-profiles`, `/blog-posts`

### URL Patterns
```
GET    /users                    # Get all users
GET    /users/123                # Get specific user
POST   /users                    # Create new user
PUT    /users/123                # Update entire user
PATCH  /users/123                # Partial user update
DELETE /users/123                # Delete user

# Nested resources
GET    /users/123/posts          # Get user's posts
POST   /users/123/posts          # Create post for user
GET    /users/123/posts/456      # Get specific user post
```

## 📊 Response Format

### Success Response Structure
```json
{
  "success": true,
  "data": {
    "id": 123,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z",
    "version": "1.0"
  }
}
```

### Collection Response Structure
```json
{
  "success": true,
  "data": [
    {
      "id": 123,
      "name": "John Doe"
    }
  ],
  "meta": {
    "total": 100,
    "page": 1,
    "perPage": 20,
    "hasNext": true,
    "hasPrev": false
  }
}
```

### Error Response Structure
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input provided",
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

## 🔐 Authentication & Authorization

### Authentication Header
```
Authorization: Bearer <jwt_token>
```

### API Key (for service-to-service)
```
X-API-Key: <api_key>
```

### Rate Limiting Headers
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

## 📝 Query Parameters

### Filtering
```
GET /users?status=active&role=admin
GET /posts?category=tech&published=true
```

### Sorting
```
GET /users?sort=name:asc
GET /posts?sort=createdAt:desc,title:asc
```

### Pagination
```
GET /users?page=2&limit=20
GET /users?offset=20&limit=20
```

### Field Selection
```
GET /users?fields=id,name,email
GET /posts?include=author,comments
```

### Search
```
GET /users?search=john
GET /posts?q=react+tutorial
```

## 📋 HTTP Status Codes

### Success Codes
- **200 OK**: Successful GET, PUT, PATCH
- **201 Created**: Successful POST
- **204 No Content**: Successful DELETE

### Client Error Codes
- **400 Bad Request**: Invalid request syntax
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: Access denied
- **404 Not Found**: Resource not found
- **409 Conflict**: Resource conflict
- **422 Unprocessable Entity**: Validation errors
- **429 Too Many Requests**: Rate limit exceeded

### Server Error Codes
- **500 Internal Server Error**: Server error
- **502 Bad Gateway**: Upstream server error
- **503 Service Unavailable**: Server temporarily unavailable

## 🔄 Versioning

### URL Versioning (Preferred)
```
https://api.example.com/v1/users
https://api.example.com/v2/users
```

### Header Versioning
```
Accept: application/vnd.api+json; version=1
API-Version: 2024-01-15
```

## 📊 Request/Response Examples

### Create User
```http
POST /v1/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securePassword123"
}
```

Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "success": true,
  "data": {
    "id": 123,
    "name": "John Doe",
    "email": "john@example.com",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

### Update User
```http
PATCH /v1/users/123
Content-Type: application/json

{
  "name": "John Smith"
}
```

### Get Users with Filtering
```http
GET /v1/users?status=active&sort=name:asc&page=1&limit=20
```

Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "success": true,
  "data": [
    {
      "id": 123,
      "name": "Alice Johnson",
      "status": "active"
    }
  ],
  "meta": {
    "total": 50,
    "page": 1,
    "perPage": 20,
    "hasNext": true,
    "hasPrev": false
  }
}
```

## 🛡️ Security Best Practices

### Input Validation
- Validate all input data
- Sanitize user inputs
- Use parameterized queries
- Implement rate limiting

### CORS Configuration
```javascript
{
  "origin": ["https://app.example.com"],
  "methods": ["GET", "POST", "PUT", "PATCH", "DELETE"],
  "allowedHeaders": ["Content-Type", "Authorization"],
  "credentials": true
}
```

### Security Headers
```
Content-Security-Policy: default-src 'self'
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
```

## 📋 API Documentation

### OpenAPI/Swagger Specification
```yaml
openapi: 3.0.3
info:
  title: ${PROJECT_NAME} API
  version: 1.0.0
  description: API for ${PROJECT_NAME}

paths:
  /users:
    get:
      summary: Get all users
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UsersResponse'
```

### Endpoint Documentation Template
```markdown
## GET /v1/users

Retrieve a list of users with optional filtering and pagination.

### Parameters
- `status` (string, optional): Filter by user status (`active`, `inactive`)
- `role` (string, optional): Filter by user role
- `page` (integer, optional): Page number (default: 1)
- `limit` (integer, optional): Items per page (default: 20, max: 100)

### Response
Success (200 OK):
```json
{
  "success": true,
  "data": [...],
  "meta": {...}
}
```

### Error Handling
- 400: Invalid query parameters
- 401: Authentication required
- 403: Insufficient permissions
```

## 🔧 Development Standards

### API Testing
- Unit tests for all endpoints
- Integration tests for complex workflows
- Performance testing for high-traffic endpoints
- Security testing for authentication and authorization

### Logging
```javascript
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "INFO",
  "message": "User created successfully",
  "userId": 123,
  "requestId": "req_123456789",
  "duration": 150
}
```

### Monitoring
- Response time monitoring
- Error rate tracking
- API usage analytics
- Uptime monitoring

---

*These API conventions ensure consistency, maintainability, and ease of use across all endpoints.*