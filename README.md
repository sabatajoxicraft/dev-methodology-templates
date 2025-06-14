# 🎯 Portable Development Methodology

A comprehensive, docs-first, project-memory-driven development methodology that works seamlessly across any environment (local, Codespaces, remote, containers).

## 🚀 Quick Start

Initialize any new project with this methodology:

```bash
git clone https://github.com/sabata-sa/dev-methodology-templates.git .methodology && .methodology/setup.sh
```

## 🏗️ Core Principles

### 1. **Docs-First Approach**
- All project documentation lives in `docs/` at root level
- Architecture decisions, style guides, and conventions are documented before coding
- Project state and context maintained in `project_memory.md`

### 2. **Component Hierarchy Building**
- Start with smallest atomic components
- Build up to larger structures systematically
- Each component follows: interfaces → component → styling → tests

### 3. **Feature-Based Organization**
```
src/features/[feature-name]/
├── components/
├── services/
├── hooks/
├── types.ts
└── __tests__/
```

### 4. **Environment Agnostic**
- Works in any development environment
- Portable templates and automation
- No local machine dependencies

## 📁 Repository Structure

```
dev-methodology-templates/
├── README.md                    # This file
├── setup.sh                     # Universal setup script
├── templates/                   # Project templates
│   ├── project_memory.md.template
│   ├── docs/                    # Documentation templates
│   ├── feature/                 # Feature templates
│   ├── component/               # Component templates
│   └── vscode/                  # VS Code configuration
├── automation/                  # Automation scripts
│   ├── create-feature.sh
│   ├── create-component.sh
│   ├── update-memory.sh
│   └── deploy.sh
├── standards/                   # Coding standards and conventions
│   ├── typescript.md
│   ├── react.md
│   ├── python.md
│   ├── git-conventions.md
│   └── documentation.md
└── examples/                    # Example implementations
    ├── react-component/
    ├── python-service/
    └── feature-complete/
```

## 🛠️ Usage

### Initialize New Project
```bash
# In your new project directory
git clone https://github.com/sabata-sa/dev-methodology-templates.git .methodology
.methodology/setup.sh
```

### Create New Feature
```bash
.methodology/automation/create-feature.sh feature-name
```

### Create New Component
```bash
.methodology/automation/create-component.sh ComponentName feature-name
```

### Update Project Memory
```bash
.methodology/automation/update-memory.sh "Completed user authentication feature"
```

## 🎯 Workflow

1. **Project Start**: Run setup script to initialize methodology
2. **Feature Planning**: Update `project_memory.md` with feature plan
3. **Component Building**: Use component hierarchy approach
4. **Documentation**: Keep docs/ updated with architectural decisions
5. **Testing**: Write tests as you build components
6. **Memory Update**: Document completion status in project_memory.md

## 🔧 VS Code Integration

The methodology automatically configures VS Code with:
- Custom file associations for methodology files
- Copilot Chat instructions for consistent code generation
- Task definitions for common workflows
- Debugging configurations
- Recommended extensions

## 🌐 Remote Development

Designed for:
- GitHub Codespaces
- VS Code Remote SSH
- Docker containers
- Local development
- Cloud IDEs

## 📋 Development Process

### For New Features:
1. Update `project_memory.md` with feature plan
2. Create data models/interfaces
3. Build basic UI components
4. Implement form validation
5. Add service/API interaction
6. Assemble full component
7. Write unit tests
8. Write integration tests
9. Update `project_memory.md` with completion status

### Code Quality:
- JSDoc comments for all functions
- Inline comments for complex logic
- TypeScript strict mode
- Error handling with meaningful messages
- Loading states for async operations
- Reusable, single-responsibility components

### Git Workflow:
- Feature branches from main
- Semantic commit messages: `type(scope): description`
- Direct merge when feature complete
- Update project memory with each significant change

## 🔄 Methodology Evolution

When you discover better practices:
1. Document them in `project_memory.md`
2. Update this methodology repository
3. Share improvements with the community

## 📞 Support

This methodology is actively maintained and evolved based on real-world usage. For questions, improvements, or contributions, please open an issue or pull request.

---

**Remember**: This methodology is your development companion that grows with you across any environment and project type.