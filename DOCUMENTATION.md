# NovaHub Documentation

**Version:** 0.0.1  
**Created by:** MrNova420 | WeNova Interactive  
**Based on:** OpenCode 1.1.48 (MIT License)

---

## Table of Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Commands Reference](#commands-reference)
5. [Configuration](#configuration)
6. [Features](#features)
7. [Usage Examples](#usage-examples)
8. [Troubleshooting](#troubleshooting)
9. [Development](#development)
10. [Contributing](#contributing)

---

## Introduction

**NovaHub** is your central development hub - an AI-powered coding assistant that runs in your terminal. It combines the power of multiple AI providers with a beautiful terminal UI, giving you an intelligent coding companion that respects your workflow.

### Key Features

- 🎨 **Beautiful TUI** - Clean terminal interface
- 🤖 **Multi-AI Support** - Use multiple AI providers
- 🔌 **Plugin System** - Extend with custom plugins
- 💻 **Web Interface** - Optional web UI
- 📦 **Session Management** - Save and restore sessions
- 🔧 **Tool Execution** - Run commands safely
- 🎯 **Agent System** - Specialized AI agents
- 🔐 **Secure** - Credentials stored locally

### Why NovaHub?

- **Terminal-First** - Works where you work
- **Fast** - Lightweight and quick
- **Flexible** - Multiple AI providers
- **Private** - Your data stays local
- **Open Source** - MIT License

---

## Installation

### Method 1: One-Line Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/MrNova420/NovaHub/master/install.sh | bash
```

### Method 2: Manual Install

1. **Install Bun:**
```bash
curl -fsSL https://bun.sh/install | bash
```

2. **Clone Repository:**
```bash
git clone https://github.com/MrNova420/NovaHub.git ~/NovaHub
cd ~/NovaHub
```

3. **Install Dependencies:**
```bash
bun install
```

4. **Build:**
```bash
cd packages/novahub
bun run script/build.ts
```

5. **Setup Global Command:**
```bash
mkdir -p ~/.local/bin
cat > ~/.local/bin/novahub << 'EOF'
#!/bin/bash
export PATH="$HOME/.bun/bin:$PATH"
exec "$HOME/NovaHub/packages/novahub/dist/novahub-linux-x64/bin/novahub" "$@"
EOF
chmod +x ~/.local/bin/novahub
```

6. **Update PATH:**
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Verify Installation

```bash
novahub --version
```

---

## Quick Start

### 1. First Run

```bash
novahub
```

This starts the TUI (Terminal User Interface).

### 2. Connect AI Provider

On first run, you'll need to connect an AI provider:

1. Press `Tab` or click "Connect a provider"
2. Choose from popular providers:
   - Anthropic (Claude)
   - OpenAI (ChatGPT)
   - Google (Gemini)
   - GitHub Copilot
   - And more...

### 3. Start Coding

Once connected, just type your question or request!

Examples:
- "Create a Python script that reads a CSV file"
- "Explain this code: [paste code]"
- "Fix the bug in main.js"
- "Write tests for this function"

---

## Commands Reference

### Basic Commands

```bash
novahub                    # Start TUI
novahub --help             # Show help
novahub --version          # Show version
novahub <project>          # Start in specific directory
```

### Running Commands

```bash
novahub run "your query"   # Run with direct message
novahub run -c             # Continue last session
novahub run -s <id>        # Continue specific session
```

### Server Modes

```bash
novahub web                # Start web interface
novahub serve              # Headless server mode
novahub attach <url>       # Attach to running server
```

### Session Management

```bash
novahub session            # Manage sessions
novahub session list       # List all sessions
novahub session delete     # Delete sessions
novahub export [id]        # Export session as JSON
novahub import <file>      # Import session
```

### Configuration

```bash
novahub auth               # Manage credentials
novahub models             # List available models
novahub agent              # Manage agents
novahub completion         # Generate shell completion
```

### Advanced

```bash
novahub debug              # Debug tools
novahub stats              # Usage statistics
novahub upgrade            # Upgrade NovaHub
novahub uninstall          # Uninstall NovaHub
```

### GitHub Integration

```bash
novahub github             # GitHub operations
novahub pr <number>        # Checkout PR and start
```

### Protocols

```bash
novahub acp                # Start ACP server
novahub mcp                # Manage MCP servers
```

---

## Configuration

### Config File Location

```
~/.novahub/novahub.jsonc
```

### Config Structure

```jsonc
{
  "providers": {
    // AI provider configurations
  },
  "theme": "novahub",
  "editor": "vim",
  "defaultModel": "anthropic/claude-3-5-sonnet",
  "plugins": []
}
```

### Environment Variables

```bash
NOVAHUB_BIN_PATH          # Override binary path
NOVAHUB_CONFIG_DIR        # Override config directory
NOVAHUB_LOG_LEVEL         # Set log level
```

---

## Features

### 1. Terminal UI (TUI)

Beautiful, responsive terminal interface with:
- Syntax highlighting
- Auto-completion
- Multi-pane layout
- Keyboard shortcuts
- Theme support

**Keyboard Shortcuts:**
- `Tab` - Access agents menu
- `Ctrl+P` - Command palette
- `Ctrl+C` - Cancel operation
- `Esc` - Close dialogs

### 2. Multi-Provider Support

Connect to multiple AI providers:
- Anthropic (Claude)
- OpenAI (GPT-4, GPT-3.5)
- Google (Gemini)
- GitHub Copilot
- Groq
- Mistral
- Cohere
- Together AI
- And many more...

### 3. Session Management

- **Auto-save** - Sessions saved automatically
- **Resume** - Continue from where you left off
- **Export/Import** - Share sessions
- **History** - Full conversation history

### 4. Agent System

Specialized agents for specific tasks:
- **Code Agent** - Write and review code
- **Debug Agent** - Find and fix bugs
- **Test Agent** - Generate tests
- **Docs Agent** - Write documentation
- **Refactor Agent** - Improve code quality

### 5. Tool Execution

Safely execute commands with:
- **Permission system** - Approve before execution
- **Sandboxing** - Safe execution environment
- **Output capture** - See results immediately
- **Error handling** - Graceful failures

### 6. Plugin System

Extend NovaHub with plugins:
- Custom tools
- New providers
- Workflow automation
- Integration with services

### 7. Web Interface

Alternative web-based UI:
```bash
novahub web
```

Access at: `http://localhost:PORT`

---

## Usage Examples

### Example 1: Code Generation

```bash
$ novahub run "Create a REST API with Express.js"
```

NovaHub will generate the code, explain it, and offer to save it.

### Example 2: Code Review

```bash
$ cd my-project
$ novahub
> Review the code in src/app.js
```

### Example 3: Bug Fixing

```bash
$ novahub run "Fix the bug where users can't login"
```

### Example 4: Test Generation

```bash
$ novahub
> Generate unit tests for utils.js
```

### Example 5: Documentation

```bash
$ novahub run "Add JSDoc comments to all functions"
```

### Example 6: Refactoring

```bash
$ novahub
> Refactor this code to use async/await
[paste code]
```

---

## Troubleshooting

### Command Not Found

```bash
# Ensure PATH is set
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Bun Not Found

```bash
# Install Bun
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
```

### Build Failures

```bash
# Clean and rebuild
cd ~/NovaHub/packages/novahub
rm -rf node_modules dist
bun install
bun run script/build.ts
```

### Permission Errors

```bash
# Fix permissions
chmod +x ~/.local/bin/novahub
chmod +x ~/NovaHub/packages/novahub/dist/*/bin/novahub
```

### Config Issues

```bash
# Reset config
rm -rf ~/.novahub
novahub  # Will recreate defaults
```

---

## Development

### Project Structure

```
NovaHub/
├── packages/
│   ├── novahub/          # Main CLI package
│   ├── console/          # Web UI
│   ├── sdk/              # SDK
│   ├── plugin/           # Plugin system
│   └── util/             # Utilities
├── docs/                 # Documentation
├── install.sh            # Installer script
└── package.json          # Root package
```

### Building from Source

```bash
cd ~/NovaHub
bun install
cd packages/novahub
bun run script/build.ts
```

### Running in Dev Mode

```bash
cd ~/NovaHub/packages/novahub
bun run dev
```

### Running Tests

```bash
cd ~/NovaHub/packages/novahub
bun test
```

---

## Contributing

NovaHub is currently in personal development. Contributions will be welcome after v1.0.0 release.

### Reporting Issues

For now, issues are tracked in `PROGRESS.md`.

---

## License

MIT License - Copyright (c) 2026 WeNova Interactive

Based on OpenCode by Anomaly (MIT License)

---

## Credits

**Created by:** MrNova420  
**Organization:** WeNova Interactive  
**Based on:** [OpenCode](https://github.com/anomalyco/opencode) by Anomaly

---

## Support

- **Documentation:** `~/NovaHub/docs/`
- **Config:** `~/.novahub/`
- **Logs:** Check terminal output

---

**Happy Coding with NovaHub!** 🚀
