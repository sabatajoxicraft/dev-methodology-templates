---
description: "Create a new feature following the methodology patterns"
---

# Create Feature

You are tasked with creating a new feature following the Portable Development Methodology.

## Instructions

1. **Review Context**: First check `project_memory.md` and `docs/` folder for current project state and guidelines.

2. **Feature Structure**: Create the feature using this structure:
   ```
   src/features/[feature-name]/
   ├── core/           # Main business logic
   ├── models/         # Data structures/schemas
   ├── services/       # External integrations
   ├── tests/          # Feature tests
   └── README.md       # Feature documentation
   ```

3. **Development Order**:
   - Define data models/interfaces first
   - Implement core business logic
   - Add external integrations/APIs
   - Create user interface (if applicable)
   - Write comprehensive tests
   - Document the feature

4. **Quality Requirements**:
   - Follow single responsibility principle
   - Include proper error handling
   - Add comprehensive test coverage
   - Use appropriate naming conventions
   - Document complex logic

5. **Final Steps**:
   - Update `project_memory.md` with feature completion status
   - Update relevant documentation in `docs/` folder

## Input Variables
- **Feature Name**: ${input:featureName:Enter the feature name (e.g., user-authentication)}
- **Description**: ${input:description:Brief description of what this feature does}

Generate the complete feature implementation following these guidelines and the project's established patterns.