---
description: "Create a new feature following the methodology patterns"
mode: "agent"
---

# Create Feature

You are tasked with creating a new feature following the Portable Development Methodology.

## Context

**Workspace**: ${workspaceFolder}
**Project**: ${workspaceFolderBasename}

Review the current project context:
- Check `project_memory.md` for current project state and decisions
- Review `docs/` folder for project-specific guidelines and architecture
- Examine existing code patterns in the workspace

## Instructions

1. **Feature Structure**: Create the feature using this structure:
   ```
   src/features/[feature-name]/
   ├── core/           # Main business logic
   ├── models/         # Data structures/schemas
   ├── services/       # External integrations
   ├── tests/          # Feature tests
   └── README.md       # Feature documentation
   ```

2. **Development Order**:
   - Define data models/interfaces first
   - Implement core business logic
   - Add external integrations/APIs
   - Create user interface (if applicable)
   - Write comprehensive tests
   - Document the feature

3. **Quality Requirements**:
   - Follow single responsibility principle
   - Include proper error handling and validation
   - Add comprehensive test coverage
   - Use appropriate naming conventions for the technology stack
   - Document complex logic with inline comments

4. **Final Steps**:
   - Update `project_memory.md` with feature completion status
   - Update relevant documentation in `docs/` folder
   - Ensure all tests pass

## Input Variables
- **Feature Name**: ${input:featureName:Enter the feature name (e.g., user-authentication)}
- **Description**: ${input:description:Brief description of what this feature does}
- **Tech Stack**: ${input:techStack:Technology stack being used (e.g., TypeScript, Python, Go)}

Generate the complete feature implementation following these guidelines and the project's established patterns.

[Reference the methodology instructions](.github/instructions/methodology.instructions.md)
[Reference the testing guidelines](.github/instructions/testing.instructions.md)
[Reference the security guidelines](.github/instructions/security.instructions.md)