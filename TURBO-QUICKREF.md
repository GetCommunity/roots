# Turborepo Quick Reference

## Most Common Commands

### Development

```bash
# Start both backend and frontend
pnpm dev:www

# Start backend only
pnpm dev:backend

# Start frontend only
pnpm dev:frontend
```

### Building

```bash
# Build everything
pnpm build

# Build specific workspace
pnpm build:validators
pnpm build:apps
pnpm build:packages

# Force rebuild (bypass cache)
pnpm build --force
```

### Testing & Quality

```bash
# Run all tests
pnpm test

# Lint all code
pnpm lint

# Type check all code
pnpm typecheck
```

### Dependency Updates

```bash
# Update gc-validators in both apps
pnpm update-validators

# Update in specific app
pnpm update:frontend-validators
pnpm update:backend-validators
```

### Utilities

```bash
# Generate dependency graph
pnpm graph

# Clean all build artifacts
pnpm clean
```

## Turborepo Filter Examples

```bash
# Build specific package
turbo build --filter=@getcommunity/gc-validators

# Build package and dependents
turbo build --filter=@getcommunity/gc-validators...

# Build package and dependencies
turbo build --filter=...@getcommunity/gc-validators

# Build multiple packages
turbo build --filter=gc-strapi --filter=gc-cf-www-ssr

# Build all apps
turbo build --filter='./apps/*'

# Build all packages
turbo build --filter='./packages/*'

# Build only changed packages (since last commit)
turbo build --filter=[HEAD^1]
```

## Understanding Cache Output

```bash
# First build
Tasks:    11 successful, 11 total
Cached:   0 cached, 11 total
Time:     45s

# Second build (full cache hit)
Tasks:    11 successful, 11 total
Cached:   11 cached, 11 total
Time:     100ms >>> FULL TURBO

# Incremental build (some cached)
Tasks:    3 successful, 11 total
Cached:   8 cached, 11 total
Time:     12s
```

## Task Dependencies

```
gc-validators (build)
    ↓
    ├─→ backend (build) → backend (test)
    └─→ frontend (build) → frontend (test)
```

## Shared Environment Variables

These variables are shared between backend and frontend:

- `PREVIEW_SECRET`
- `RECAPTCHA_SECRET_KEY`
- `SHARPSPRING_ID`
- `SHARPSPRING_SECRET_KEY`
- `TEAMWORK_AUTH_TOKEN`
- `VITE_GA4_STREAM_ID`
- `VITE_RECAPTCHA_SITE_KEY`
- `VITE_SHARPSPRING_CLIENT_ID`
- `VITE_SHARPSPRING_DOMAIN_ID`

## Troubleshooting

### Cache not working?

```bash
# Clear cache and rebuild
pnpm clean
pnpm build
```

### Submodule out of sync?

```bash
# Reset to committed reference
git submodule update --init --recursive
```

### Build failing after submodule update?

```bash
# Force rebuild
pnpm build --force
```

## File Locations

- **Turborepo config**: [turbo.json](file:///Users/joeyg/GitGC/@getcommunity/turbo.json)
- **Root package**: [package.json](file:///Users/joeyg/GitGC/@getcommunity/package.json)
- **Documentation**: [TURBO-README.md](file:///Users/joeyg/GitGC/@getcommunity/TURBO-README.md)
- **Cache directory**: `.turbo/`

## Key Improvements Made

✅ Enabled caching for `build`, `lint`, `typecheck`, `test`  
✅ Added proper task dependencies (`^build`)  
✅ Configured shared environment variables  
✅ Updated scripts to use Turborepo filters  
✅ Added comprehensive documentation

## Learn More

- Full documentation: [TURBO-README.md](file:///Users/joeyg/GitGC/@getcommunity/TURBO-README.md)
- Official docs: https://turbo.build/repo/docs
