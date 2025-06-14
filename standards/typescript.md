# TypeScript Coding Standards

## 🎯 Overview

These standards ensure consistent, maintainable, and type-safe TypeScript code across all projects using the portable development methodology.

## 📝 General Principles

### 1. Strict Type Safety
- Enable strict mode in `tsconfig.json`
- Avoid `any` type - use specific types or `unknown`
- Use type assertions sparingly and with purpose
- Prefer type guards over type assertions

```typescript
// ❌ Avoid
function processData(data: any): any {
  return data.someProperty;
}

// ✅ Prefer
interface UserData {
  id: string;
  name: string;
  email: string;
}

function processUserData(data: UserData): string {
  return data.name;
}
```

### 2. Naming Conventions

#### Variables and Functions
```typescript
// ✅ camelCase for variables and functions
const userName = 'john_doe';
const isAuthenticated = true;

function getUserProfile() { }
function calculateTotalPrice() { }
```

#### Classes and Interfaces
```typescript
// ✅ PascalCase for classes and interfaces
class UserService { }
interface ApiResponse { }
interface IUserRepository { } // Optional 'I' prefix for interfaces
```

#### Constants
```typescript
// ✅ UPPER_SNAKE_CASE for constants
const API_BASE_URL = 'https://api.example.com';
const MAX_RETRY_ATTEMPTS = 3;
```

#### Types and Enums
```typescript
// ✅ PascalCase for types and enums
type UserRole = 'admin' | 'user' | 'guest';

enum HttpStatusCode {
  OK = 200,
  BAD_REQUEST = 400,
  UNAUTHORIZED = 401,
  NOT_FOUND = 404,
}
```

## 🏗️ Type Definitions

### Interface Design
```typescript
// ✅ Well-structured interface
interface User {
  readonly id: string;
  name: string;
  email: string;
  role: UserRole;
  createdAt: Date;
  updatedAt?: Date;
  metadata?: Record<string, unknown>;
}

// ✅ Generic interfaces
interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  errors?: string[];
}
```

### Union Types
```typescript
// ✅ Use union types for controlled values
type Theme = 'light' | 'dark' | 'auto';
type HttpMethod = 'GET' | 'POST' | 'PUT' | 'PATCH' | 'DELETE';

// ✅ Discriminated unions
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: unknown;
}

interface ErrorState {
  status: 'error';
  error: string;
}

type AsyncState = LoadingState | SuccessState | ErrorState;
```

### Generic Types
```typescript
// ✅ Generic constraints
interface Repository<T extends { id: string }> {
  findById(id: string): Promise<T | null>;
  create(entity: Omit<T, 'id'>): Promise<T>;
  update(id: string, updates: Partial<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

// ✅ Utility types
type CreateUserRequest = Omit<User, 'id' | 'createdAt'>;
type UserUpdate = Partial<Pick<User, 'name' | 'email'>>;
```

## 🔧 Functions and Methods

### Function Signatures
```typescript
// ✅ Clear function signatures
async function fetchUser(
  id: string,
  options?: {
    includeMetadata?: boolean;
    timeout?: number;
  }
): Promise<User | null> {
  // Implementation
}

// ✅ Return type annotations for complex types
function createUserFilter(
  criteria: UserFilterCriteria
): (user: User) => boolean {
  return (user) => {
    // Filter logic
    return true;
  };
}
```

### Error Handling
```typescript
// ✅ Custom error types
class ValidationError extends Error {
  constructor(
    public field: string,
    message: string
  ) {
    super(message);
    this.name = 'ValidationError';
  }
}

// ✅ Result pattern for error handling
type Result<T, E = Error> = 
  | { success: true; data: T }
  | { success: false; error: E };

async function safeApiCall<T>(
  apiCall: () => Promise<T>
): Promise<Result<T>> {
  try {
    const data = await apiCall();
    return { success: true, data };
  } catch (error) {
    return { 
      success: false, 
      error: error instanceof Error ? error : new Error(String(error))
    };
  }
}
```

## 🎨 Classes and Objects

### Class Structure
```typescript
// ✅ Well-structured class
class UserService {
  private readonly repository: UserRepository;
  private readonly logger: Logger;

  constructor(
    repository: UserRepository,
    logger: Logger
  ) {
    this.repository = repository;
    this.logger = logger;
  }

  async createUser(userData: CreateUserRequest): Promise<User> {
    this.logger.info('Creating user', { email: userData.email });
    
    try {
      const user = await this.repository.create(userData);
      this.logger.info('User created successfully', { userId: user.id });
      return user;
    } catch (error) {
      this.logger.error('Failed to create user', { error });
      throw error;
    }
  }

  // Use readonly for methods that don't modify state
  readonly getUserById = async (id: string): Promise<User | null> => {
    return this.repository.findById(id);
  };
}
```

### Object Patterns
```typescript
// ✅ Factory pattern
interface UserFactory {
  createUser(type: UserType): User;
}

class StandardUserFactory implements UserFactory {
  createUser(type: UserType): User {
    switch (type) {
      case 'admin':
        return new AdminUser();
      case 'regular':
        return new RegularUser();
      default:
        throw new Error(`Unknown user type: ${type}`);
    }
  }
}

// ✅ Builder pattern
class UserBuilder {
  private user: Partial<User> = {};

  setName(name: string): this {
    this.user.name = name;
    return this;
  }

  setEmail(email: string): this {
    this.user.email = email;
    return this;
  }

  build(): User {
    if (!this.user.name || !this.user.email) {
      throw new Error('Name and email are required');
    }
    return {
      id: generateId(),
      name: this.user.name,
      email: this.user.email,
      role: 'user',
      createdAt: new Date(),
    };
  }
}
```

## 🔍 Type Guards and Assertions

### Type Guards
```typescript
// ✅ Custom type guards
function isUser(obj: unknown): obj is User {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'id' in obj &&
    'name' in obj &&
    'email' in obj
  );
}

function isErrorWithMessage(error: unknown): error is { message: string } {
  return (
    typeof error === 'object' &&
    error !== null &&
    'message' in error &&
    typeof (error as Record<string, unknown>).message === 'string'
  );
}

// ✅ Using type guards
function handleApiResponse(response: unknown): void {
  if (isUser(response)) {
    console.log(`User: ${response.name}`);
  } else {
    console.log('Invalid user data');
  }
}
```

### Assertion Functions
```typescript
// ✅ Assertion functions
function assertIsUser(obj: unknown): asserts obj is User {
  if (!isUser(obj)) {
    throw new Error('Object is not a valid User');
  }
}

function processUserData(data: unknown): void {
  assertIsUser(data);
  // data is now typed as User
  console.log(data.name);
}
```

## 📦 Module Organization

### Export Patterns
```typescript
// ✅ Named exports (preferred)
export { UserService } from './UserService';
export { UserRepository } from './UserRepository';
export type { User, CreateUserRequest } from './types';

// ✅ Default exports for single-purpose modules
export default class ApiClient {
  // Implementation
}

// ✅ Barrel exports in index.ts
export * from './services';
export * from './types';
export * from './utils';
```

### Import Patterns
```typescript
// ✅ Organized imports
// External libraries
import React from 'react';
import { Router } from 'express';

// Internal modules (absolute imports)
import { UserService } from '@/services/UserService';
import { logger } from '@/utils/logger';

// Relative imports for closely related files
import { validateUserInput } from './validation';
import { UserModel } from './UserModel';
```

## 🧪 Testing with TypeScript

### Test Types
```typescript
// ✅ Type-safe test utilities
interface TestUser extends User {
  _isTestUser: true;
}

function createTestUser(overrides: Partial<User> = {}): TestUser {
  return {
    id: 'test-user-id',
    name: 'Test User',
    email: 'test@example.com',
    role: 'user',
    createdAt: new Date(),
    _isTestUser: true,
    ...overrides,
  };
}

// ✅ Mock types
type MockUserService = jest.Mocked<UserService>;

const mockUserService: MockUserService = {
  createUser: jest.fn(),
  getUserById: jest.fn(),
  updateUser: jest.fn(),
  deleteUser: jest.fn(),
} as MockUserService;
```

## 📋 Best Practices

### 1. Progressive Enhancement
```typescript
// ✅ Start with basic types, enhance as needed
// Basic
interface User {
  id: string;
  name: string;
}

// Enhanced
interface EnhancedUser extends User {
  email: string;
  role: UserRole;
  permissions: Permission[];
}
```

### 2. Composition over Inheritance
```typescript
// ✅ Composition
interface Timestamped {
  createdAt: Date;
  updatedAt?: Date;
}

interface User extends Timestamped {
  id: string;
  name: string;
  email: string;
}
```

### 3. Immutability
```typescript
// ✅ Readonly properties
interface ImmutableUser {
  readonly id: string;
  readonly email: string;
  readonly metadata: Readonly<Record<string, unknown>>;
}

// ✅ Utility types for immutability
type ReadonlyUser = Readonly<User>;
type DeepReadonlyUser = DeepReadonly<User>;
```

### 4. Documentation
```typescript
/**
 * Represents a user in the system.
 * 
 * @example
 * ```typescript
 * const user: User = {
 *   id: 'user-123',
 *   name: 'John Doe',
 *   email: 'john@example.com',
 *   role: 'user',
 *   createdAt: new Date()
 * };
 * ```
 */
interface User {
  /** Unique identifier for the user */
  id: string;
  
  /** Full name of the user */
  name: string;
  
  /** Email address (must be unique) */
  email: string;
  
  /** User's role in the system */
  role: UserRole;
  
  /** When the user was created */
  createdAt: Date;
  
  /** When the user was last updated */
  updatedAt?: Date;
}
```

## ⚠️ Common Pitfalls to Avoid

### 1. Overusing `any`
```typescript
// ❌ Avoid
function process(data: any): any {
  return data.whatever;
}

// ✅ Better
function process<T>(data: T): T {
  return data;
}
```

### 2. Ignoring null/undefined
```typescript
// ❌ Avoid
function getUserName(user: User): string {
  return user.name.toUpperCase(); // Could throw if name is undefined
}

// ✅ Better
function getUserName(user: User): string {
  return user.name?.toUpperCase() ?? 'Unknown';
}
```

### 3. Not using strict mode
```typescript
// ✅ Always enable in tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true
  }
}
```

---

These TypeScript standards ensure code quality, maintainability, and developer productivity across all projects.