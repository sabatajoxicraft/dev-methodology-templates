# Git Conventions and Workflow

## 🎯 Overview

Consistent Git practices ensure clean history, clear communication, and efficient collaboration across all projects using the portable development methodology.

## 📝 Commit Message Format

### Gitmoji + Conventional Commits Structure
We use [Gitmoji](https://gitmoji.dev/) for visual clarity combined with conventional commits for semantic meaning:

```
<gitmoji> <type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Primary Gitmoji Reference
- 🎨 `:art:` - Improve structure/format of code
- 🐛 `:bug:` - Fix bugs
- ✨ `:sparkles:` - Introduce new features
- 📝 `:memo:` - Add/update documentation
- 🚀 `:rocket:` - Deploy/release changes
- 💄 `:lipstick:` - Add/update UI and style
- 🎉 `:tada:` - Begin project
- ✅ `:white_check_mark:` - Add/update/pass tests
- 🔒️ `:lock:` - Fix security issues
- 🔧 `:wrench:` - Add/update configuration
- 🌐 `:globe_with_meridians:` - Internationalization
- 💚 `:green_heart:` - Fix CI build
- ⬇️ `:arrow_down:` - Downgrade dependencies
- ⬆️ `:arrow_up:` - Upgrade dependencies
- 📌 `:pushpin:` - Pin dependencies
- 👷 `:construction_worker:` - Add/update CI system
- 📈 `:chart_with_upwards_trend:` - Add/update analytics
- ♻️ `:recycle:` - Refactor code
- ➕ `:heavy_plus_sign:` - Add dependency
- ➖ `:heavy_minus_sign:` - Remove dependency
- 🔨 `:hammer:` - Add/update development scripts
- 🌱 `:seedling:` - Add/update seed files
- 🚩 `:triangular_flag_on_post:` - Add/update/remove feature flags
- 🥅 `:goal_net:` - Catch errors
- 💫 `:dizzy:` - Add/update animations
- 🗑️ `:wastebasket:` - Deprecate code
- 🛂 `:passport_control:` - Work on authorization/roles/permissions
- 🩹 `:adhesive_bandage:` - Simple fix for non-critical issue
- 🧐 `:monocle_face:` - Data exploration/inspection
- ⚰️ `:coffin:` - Remove dead code
- 🧪 `:test_tube:` - Add failing test
- 👔 `:necktie:` - Add/update business logic
- 🩺 `:stethoscope:` - Add/update healthcheck
- 🧱 `:bricks:` - Infrastructure related changes
- 🧑‍💻 `:technologist:` - Improve developer experience
- 💸 `:money_with_wings:` - Add sponsorships or money related stuff
- 🧵 `:thread:` - Add/update code related to multithreading or concurrency
- 🦺 `:safety_vest:` - Add/update code related to validation

### Commit Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **perf**: A code change that improves performance
- **revert**: Reverts a previous commit

### Scope Examples
- **auth**: Authentication related changes
- **ui**: User interface changes
- **api**: API related changes
- **db**: Database changes
- **config**: Configuration changes
- **deps**: Dependency updates

### Gitmoji + Conventional Commit Examples
```bash
✨ feat(auth): add password reset functionality
🐛 fix(ui): resolve button alignment issue in mobile view
📝 docs(readme): update installation instructions
♻️ refactor(api): simplify user data validation
🧪 test(user): add unit tests for user service
⬆️ chore(deps): update typescript to v5.0
🎨 style(format): fix indentation in user component
🚀 deploy: release version 1.2.0
🔒️ fix(security): patch authentication vulnerability
💄 feat(ui): add dark mode theme support
🌐 feat(i18n): add French language support
💚 fix(ci): resolve failing build pipeline
🔧 chore(config): update ESLint configuration
📈 feat(analytics): add user behavior tracking
🥅 fix(error): improve error handling in API calls
⚰️ refactor(cleanup): remove deprecated user methods
🧱 chore(infra): update Docker configuration
🦺 feat(validation): add input sanitization
```

### Multi-file Change Format
For complex changes affecting multiple files:
```bash
✨ feat(auth): implement complete user authentication system

📁 [AuthService.ts] - add core authentication logic
📁 [LoginForm.tsx] - create login user interface  
📁 [auth.test.ts] - add comprehensive test coverage
📁 [project_memory.md] - update with auth implementation details
```

## 🌿 Branching Strategy

### Branch Types
- **main/master**: Production-ready code
- **feature/[name]**: New features
- **fix/[name]**: Bug fixes
- **docs/[name]**: Documentation updates
- **refactor/[name]**: Code refactoring
- **chore/[name]**: Maintenance tasks

### Branch Naming
```bash
feature/user-authentication
feature/dashboard-analytics
fix/login-form-validation
fix/mobile-navigation-bug
docs/api-documentation
docs/setup-instructions
refactor/user-service-cleanup
chore/update-dependencies
```

### Workflow
```bash
# 1. Start from main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/user-authentication

# 3. Work on feature with regular commits
git add .
git commit -m "feat(auth): add login form component"

# 4. Keep branch updated (optional but recommended)
git checkout main
git pull origin main
git checkout feature/user-authentication
git rebase main

# 5. Push feature branch
git push origin feature/user-authentication

# 6. Create pull request
# Use GitHub/GitLab UI or CLI

# 7. After merge, clean up
git checkout main
git pull origin main
git branch -d feature/user-authentication
```

## 🔄 Development Workflow

### Daily Workflow
```bash
# Morning: Start with latest changes
git checkout main
git pull origin main

# Create or switch to feature branch
git checkout -b feature/new-feature
# or
git checkout feature/existing-feature

# Work on feature
# ... make changes ...

# Commit regularly with meaningful messages
git add .
git commit -m "feat(feature): implement core functionality"

# Update project memory
./scripts/update-memory "Implemented core functionality for new feature"

# Push to remote
git push origin feature/new-feature

# End of day: Ensure work is pushed
git push origin feature/new-feature
```

### Feature Completion Workflow
```bash
# 1. Ensure all tests pass
npm test

# 2. Update documentation
# Edit relevant docs in docs/ folder

# 3. Update project memory
./scripts/update-memory "Completed new-feature implementation"

# 4. Final commit
git add .
git commit -m "feat(feature): complete new-feature implementation

- Add comprehensive test coverage
- Update documentation
- Update project memory with completion status"

# 5. Push and create PR
git push origin feature/new-feature
# Create pull request via GitHub/GitLab
```

## 📋 Pull Request Guidelines

### PR Title Format
```
type(scope): brief description of changes
```

### PR Description Template
```markdown
## 🎯 Summary
Brief description of what this PR accomplishes.

## 🧩 Changes Made
- [ ] Feature implementation
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Project memory updated

## 🧪 Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## 📚 Documentation
- [ ] Code comments added
- [ ] README updated (if needed)
- [ ] API documentation updated (if needed)

## 🔗 Related Issues
Closes #123
Related to #456

## 📸 Screenshots (if applicable)
[Add screenshots for UI changes]

## ✅ Checklist
- [ ] Code follows project style guide
- [ ] Self-review completed
- [ ] Tests added for new functionality
- [ ] Documentation updated
- [ ] Project memory updated
```

### PR Review Process
1. **Self Review**: Review your own changes before requesting review
2. **Automated Checks**: Ensure CI/CD passes
3. **Peer Review**: At least one approval required
4. **Testing**: Manual testing in review environment
5. **Merge**: Squash and merge with clean commit message

## 🏷️ Tagging and Releases

### Semantic Versioning
- **MAJOR**: Breaking changes (v1.0.0 → v2.0.0)
- **MINOR**: New features, backward compatible (v1.0.0 → v1.1.0)
- **PATCH**: Bug fixes, backward compatible (v1.0.0 → v1.0.1)

### Release Process
```bash
# 1. Update version in package.json
npm version patch  # or minor, major

# 2. Create release commit
git add .
git commit -m "chore(release): bump version to v1.0.1"

# 3. Create and push tag
git tag v1.0.1
git push origin main --tags

# 4. Create GitHub release
gh release create v1.0.1 --title "Release v1.0.1" --notes "Bug fixes and improvements"
```

## 🔧 Git Configuration

### Global Git Setup
```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Enable helpful features
git config --global pull.rebase false
git config --global push.default simple
git config --global core.autocrlf input  # For Unix/Mac
git config --global core.autocrlf true   # For Windows

# Set up aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

### Project-specific .gitignore
```bash
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist/
build/
out/

# Environment files
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS generated files
.DS_Store
Thumbs.db

# Logs
logs
*.log

# Coverage
coverage/
.nyc_output

# Keep methodology files
!.methodology/
```

## 📊 Git Best Practices

### Commit Frequency
- **Small, frequent commits** over large, infrequent ones
- **One logical change per commit**
- **Commit working code** - don't commit broken code

### Commit Messages
```bash
# ✅ Good
feat(auth): add login validation with email format check
fix(ui): resolve mobile menu not closing on item selection
docs(api): add authentication endpoint documentation

# ❌ Avoid
WIP
fix stuff
Updated files
commit
asdf
```

### Branch Management
- **Keep branches focused** - one feature per branch
- **Delete merged branches** to keep repository clean
- **Rebase feature branches** to maintain clean history
- **Use descriptive branch names**

### Merge vs Rebase
```bash
# Use merge for feature integration (preserves context)
git checkout main
git merge feature/user-authentication

# Use rebase for cleaning up feature branch history
git checkout feature/user-authentication
git rebase main

# Interactive rebase for squashing commits
git rebase -i HEAD~3
```

## 🚨 Emergency Procedures

### Hotfix Workflow
```bash
# 1. Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug-fix

# 2. Make minimal fix
# ... fix the issue ...

# 3. Test thoroughly
npm test

# 4. Commit and push
git add .
git commit -m "fix(critical): resolve security vulnerability in auth"
git push origin hotfix/critical-bug-fix

# 5. Create emergency PR for immediate review
# Deploy after approval
```

### Undo Operations
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Undo specific file changes
git checkout -- filename.js

# Revert a merged commit
git revert -m 1 <merge-commit-hash>
```

## 📈 Measuring Git Health

### Repository Health Indicators
- **Commit frequency**: Regular, consistent commits
- **Branch lifecycle**: Short-lived feature branches
- **PR review time**: Quick turnaround on reviews
- **Merge conflicts**: Minimal conflicts indicate good coordination
- **Test coverage**: Consistent test coverage across commits

### Git Analytics
```bash
# Commit activity
git log --oneline --since="1 month ago" | wc -l

# Contributors
git shortlog -sn --since="1 month ago"

# Files changed most frequently
git log --format=format: --name-only | grep -v '^$' | sort | uniq -c | sort -rn | head -10
```

---

These Git conventions ensure clean, maintainable, and collaborative development across all environments and team sizes.