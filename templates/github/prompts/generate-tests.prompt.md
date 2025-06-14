---
description: "Generate comprehensive tests following methodology patterns"
mode: "agent"
---

# Generate Tests

Generate comprehensive tests for the selected code following the Portable Development Methodology testing standards.

## Context

**Workspace**: ${workspaceFolder}
**Selected Code**: ${selection}
**Current File**: ${file}
**File Directory**: ${fileDirname}

Analyze the existing test patterns in the project and follow the established conventions.

## Testing Guidelines

### 1. Test Organization
- **Unit Tests**: Test individual functions/methods in isolation
- **Integration Tests**: Test feature workflows and external integrations
- **End-to-End Tests**: Test complete user journeys (when applicable)

### 2. Test Structure (AAA Pattern)
```
// Arrange - Set up test data and conditions
// Act - Execute the code being tested  
// Assert - Verify the results
```

### 3. Test Naming Convention
Use descriptive names following the pattern:
- `test_[what]_[when]_[expected_result]`
- Example: `test_user_login_with_valid_credentials_succeeds`

### 4. Test Coverage Requirements
- **Happy Path**: Normal operation scenarios
- **Error Scenarios**: Invalid inputs, network failures, etc.
- **Edge Cases**: Boundary conditions, empty inputs, null values
- **Security**: Authentication, authorization, input validation

### 5. Framework Guidelines
- **JavaScript/TypeScript**: Jest, Vitest, or project-appropriate framework
- **Python**: pytest or unittest
- **Go**: Built-in testing package
- **Java**: JUnit 5
- **Other languages**: Use appropriate testing framework

### 6. Mock Strategy
- Mock external dependencies (APIs, databases, file systems)
- Keep tests independent and deterministic
- Use dependency injection patterns where possible

### 7. Test Data
- Use meaningful test data that represents real scenarios
- Consider creating test fixtures for complex data structures
- Avoid hardcoded values where possible

## Input Variables
- **Test Type**: ${input:testType:What type of tests? (unit/integration/e2e)}
- **Coverage Focus**: ${input:coverage:Any specific scenarios to focus on?}
- **Framework**: ${input:framework:Testing framework to use (auto-detect if not specified)}

## Output Requirements
Generate:
1. **Unit tests** for all public functions/methods
2. **Integration tests** for complex workflows
3. **Mock implementations** for external dependencies
4. **Test fixtures** if needed for complex data
5. **Setup/teardown** code if required
6. **Test configuration** files if needed

Ensure tests are:
- Comprehensive yet focused
- Fast and reliable
- Easy to understand and maintain
- Following the project's existing test patterns
- Properly organized in the test directory structure

## Additional Considerations
- Check for existing test utilities and helpers to reuse
- Follow the project's test file naming conventions
- Include performance tests for critical paths if appropriate
- Consider accessibility tests for UI components
- Add documentation for complex test scenarios

[Reference the testing guidelines](.github/instructions/testing.instructions.md)
[Reference the methodology instructions](.github/instructions/methodology.instructions.md)