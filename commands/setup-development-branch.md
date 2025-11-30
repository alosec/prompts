# Setup Development Branch

Create and configure a new development branch for feature work.

## Create New Feature Branch
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name
```

## Development Workflow
1. **Work on feature** in feature branch
2. **Commit changes** regularly with descriptive messages
3. **Test locally** with `npm run dev` (fixed to port 4321)
4. **Merge to develop** when feature is complete
5. **Deploy to production** when develop is stable

## Branch Structure
- `main` = Production (pedicalendar.com)
- `develop` = Development/staging 
- `feature/*` = Individual features

## Common Commands
```bash
# Check current branch and status
git status

# Switch branches
git checkout develop
git checkout main

# Merge feature to develop
git checkout develop
git merge feature/your-feature-name

# Clean up completed feature branch
git branch -d feature/your-feature-name
```

## Development Server
- Always runs on http://localhost:4321 (fixed port)
- Fails if port is busy (no random ports)
- Use `lsof -ti:4321 | xargs kill -9` to kill existing processes