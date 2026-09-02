# Cloud Functions Commands

## Quick Commands

### Lint & Fix
```bash
# Run linter
cd functions && npm run lint

# Fix linting issues automatically
cd functions && npm run lint -- --fix
```

### Build
```bash
# Build TypeScript to JavaScript
cd functions && npm run build

# Build with watch mode (auto-rebuild on changes)
cd functions && npm run build:watch
```

### Deploy
```bash
# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:functionName
```

### Local Development
```bash
# Start local emulator
cd functions && npm run serve

# Open functions shell
cd functions && npm run shell
```

### Logs
```bash
# View function logs
firebase functions:log

# Follow logs in real-time
firebase functions:log --tail
```

## Common Workflow
1. Make changes to TypeScript files in `functions/src/`
2. Run `npm run lint -- --fix` to fix formatting
3. Run `npm run build` to compile
4. Test locally with `npm run serve`
5. Deploy with `firebase deploy --only functions`