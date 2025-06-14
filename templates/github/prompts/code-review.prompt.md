---
description: "Perform comprehensive code review following methodology standards"
---

# Code Review

Perform a thorough code review of the selected code following the Portable Development Methodology standards.

## Review Criteria

### 1. Code Quality
- **Correctness**: Does the code work as intended?
- **Readability**: Is the code easy to understand?
- **Maintainability**: Will this code be easy to modify in the future?
- **Performance**: Are there any obvious performance issues?

### 2. Architecture & Design
- **Single Responsibility**: Does each function/class have a single, clear purpose?
- **Separation of Concerns**: Are different aspects properly separated?
- **Feature Organization**: Is code properly organized in the feature-based structure?
- **Reusability**: Can components be reused appropriately?

### 3. Security
- **Input Validation**: Are all inputs properly validated and sanitized?
- **Authentication/Authorization**: Are security measures properly implemented?
- **Error Handling**: Do error messages avoid exposing sensitive information?
- **Dependencies**: Are third-party dependencies secure and up-to-date?

### 4. Testing
- **Test Coverage**: Are there appropriate unit and integration tests?
- **Test Quality**: Are tests comprehensive and well-structured?
- **Edge Cases**: Are boundary conditions and error scenarios tested?

### 5. Documentation
- **Code Comments**: Is complex logic properly documented?
- **API Documentation**: Are public interfaces documented?
- **README Updates**: Is feature documentation current?
- **Project Memory**: Should `project_memory.md` be updated?

### 6. Methodology Compliance
- **Standards**: Does code follow the project's style guide in `docs/style-guide.md`?
- **Patterns**: Are established patterns and conventions followed?
- **Structure**: Is the feature-based organization maintained?

## Review Format

Provide feedback in this structure:
1. **Summary**: Overall assessment and key findings
2. **Strengths**: What's done well
3. **Issues**: Problems that need to be addressed (categorized by severity)
4. **Suggestions**: Improvement recommendations
5. **Action Items**: Specific changes needed before approval

Reference the current selection: ${selection}