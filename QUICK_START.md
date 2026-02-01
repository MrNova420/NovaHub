# NovaHub Quick Start Guide

## Installation Steps

### 1. Install Bun (Required)
```bash
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc  # Reload shell
bun --version     # Verify installation
```

### 2. Install Dependencies
```bash
cd ~/NovaHub
bun install
```

### 3. Build NovaHub
```bash
cd ~/NovaHub
bun run build
```

### 4. Test the CLI
```bash
# Run in dev mode
cd ~/NovaHub/packages/novahub
bun run dev

# Or test the built binary
./bin/novahub --version
```

### 5. Install Globally (Optional)
```bash
cd ~/NovaHub/packages/novahub
bun link  # Makes 'novahub' command available globally
novahub --help
```

## Quick Commands

```bash
novahub              # Start TUI
novahub run "help"   # Run with message
novahub web          # Start web UI
novahub --version    # Check version
novahub --help       # Full help
```

## Configuration

Default config: `~/.novahub/novahub.jsonc`

## Troubleshooting

**Bun install issues:**
```bash
bun -v
bun install --force
```

**Build errors:**
```bash
bun run clean
bun install
bun run build
```

**Permission issues:**
```bash
chmod +x ~/NovaHub/packages/novahub/bin/novahub
```

## Development

```bash
# Watch mode
bun run dev

# Type checking
bun run typecheck

# Run tests
bun test
```

---
Created by MrNova420 | WeNova Interactive
