# 🎯 Portable Development Methodology

A comprehensive, docs-first, project-memory-driven development methodology that works seamlessly across any environment (local, Codespaces, remote, containers) and any technology stack.

## 🚀 Quick Start

Initialize any new project with this methodology:

```bash
git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology && .methodology/setup.sh
```

## 🏗️ Core Principles

### 1. **Tech-Stack Agnostic**
- Works with any programming language or framework
- Principle-based approach, not technology-specific
- Adapts to your chosen technology stack

### 2. **Docs-First Approach**
- All project documentation lives in `docs/` at root level
- Architecture decisions, style guides, and conventions are documented before coding
- Project state and context maintained in `project_memory.md`

### 3. **Hierarchical Building**
- Start with smallest atomic units (functions, classes, modules)
- Build up to larger structures systematically
- Each module follows: models → core logic → integrations → tests

### 4. **Feature-Based Organization**
```
src/features/[feature-name]/
├── core/           # Business logic
├── models/         # Data structures
├── services/       # External integrations
└── tests/          # Feature tests
```

### 5. **Environment Agnostic**
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
│   ├── README.md.template       # Tech-agnostic README
│   ├── docs/                    # Documentation templates
│   │   ├── architecture.md
│   │   ├── style-guide.md
│   │   └── api-conventions.md
│   ├── .gitignore.template
│   └── vscode/                  # VS Code configuration
├── automation/                  # Automation scripts
│   ├── create-feature.sh        # Tech-agnostic feature creation
│   ├── create-component.sh      # Universal module creation
│   ├── update-memory.sh
│   ├── status.sh
│   └── deploy.sh
├── standards/                   # Universal coding standards
│   ├── coding-standards.md      # Language-agnostic standards
│   └── git-conventions.md
└── examples/                    # Example implementations
    ├── javascript-project/
    ├── python-project/
    ├── go-project/
    └── java-project/
```

## 🛠️ Usage

### Initialize New Project
```bash
# In your new project directory
git clone https://github.com/sabatajoxicraft/dev-methodology-templates.git .methodology
.methodology/setup.sh
```

### Create New Feature
```bash
./scripts/create-feature user-authentication
```

### Create New Module/Component
```bash
./scripts/create-component UserService user-authentication core
./scripts/create-component AuthValidator user-authentication services
```

### Update Project Memory
```bash
./scripts/update-memory "Completed user authentication feature"
```

## 🎯 Universal Workflow

1. **Project Start**: Run setup script to initialize methodology
2. **Feature Planning**: Update `project_memory.md` with feature plan
3. **Module Building**: Use hierarchical approach (models → core → services → tests)
4. **Documentation**: Keep docs/ updated with architectural decisions
5. **Testing**: Write tests as you build modules
6. **Memory Update**: Document completion status in project_memory.md

## 🔧 VS Code Integration

The methodology automatically configures VS Code with:
- Tech-agnostic file associations for methodology files
- Copilot Chat instructions for universal development principles
- Task definitions for common workflows
- Debugging configurations
- Recommended extensions

### Copilot Integration
Your VS Code is configured with universal development instructions that:
- Work with any technology stack
- Follow docs-first and project-memory-driven approaches
- Implement feature-based organization
- Maintain consistent quality standards

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
2. Define data models/schemas/interfaces
3. Implement core business logic
4. Add external integrations/APIs
5. Create user interface (if applicable)
6. Write unit tests
7. Write integration tests
8. Update `project_memory.md` with completion status

### Code Quality (Language Agnostic):
- Use appropriate documentation standards (JSDoc, docstrings, etc.)
- Add inline comments for complex logic
- Implement proper error handling and validation
- Provide meaningful error messages
- Create reusable, single-responsibility modules
- Follow language-specific best practices

### Git Workflow:
- Feature branches from main
- Semantic commit messages: `type(scope): description`
- Direct merge when feature complete
- Update project memory with each significant change

## 🔄 Methodology Evolution

When you discover better practices:
1. Document them in `project_memory.md`
2. Suggest updates to this methodology repository
3. Share improvements with the community

## 🌍 Language Support

This methodology supports any programming language or framework:

- **JavaScript/TypeScript**: Node.js, React, Vue, Angular, etc.
- **Python**: Django, Flask, FastAPI, data science projects
- **Go**: Web services, CLI tools, microservices
- **Java**: Spring Boot, enterprise applications
- **C#**: .NET applications, web APIs
- **Rust**: System programming, web services
- **PHP**: Laravel, Symfony, WordPress
- **Ruby**: Rails, Sinatra applications
- **And many more...**

The automation scripts automatically detect your project type and create appropriate file structures and templates.

## 📞 Support

This methodology is actively maintained and evolved based on real-world usage across different technology stacks. For questions, improvements, or contributions, please open an issue or pull request.

---

**Remember**: This methodology is your universal development companion that adapts to any technology stack and grows with you across any environment and project type.