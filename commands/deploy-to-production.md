# Deploy to Production

Complete workflow for deploying changes from development branch to production. Adapts to the current project's deployment setup.

## Prerequisites
- Changes committed and tested on development branch
- Currently on development branch with clean working directory
- Production deployment configuration verified

## Deployment Steps

### 1. Merge development to main
```bash
git checkout main
git pull origin main    # Ensure main is up to date
git merge develop       # Fast-forward merge (or your dev branch)
git push origin main    # Push to remote
```

### 2. Build and Deploy
Check for project-specific deployment:
- **Cloudflare Pages**: `wrangler pages deploy dist/ --project-name=[project-name]`
- **Vercel**: `vercel --prod`
- **Netlify**: `netlify deploy --prod`
- **Custom**: Check package.json scripts or deployment docs

Common build command:
```bash
npm run build  # or yarn build, or project-specific build command
```

### 3. Verify Deployment
- Check production URL for changes
- Test core functionality
- Monitor for any errors or issues
- Verify deployment completed successfully

### 4. Return to Development
```bash
git checkout develop  # Switch back to development branch
```

## Troubleshooting
- **Build fails**: Check console errors, fix issues on development branch
- **Deploy fails**: Check authentication and project configuration
- **Site not updating**: Allow time for CDN propagation
- **Rollback needed**: Use platform-specific rollback mechanisms

## Notes
- Manual deployment provides full control over releases
- Each deploy typically creates deployment history for rollback
- Main branch represents production state
- Development branch represents active work

Arguments: $ARGUMENTS