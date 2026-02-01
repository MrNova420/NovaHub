# NovaHub - Quick Reference Card

## ✅ Installation Complete!

Your NovaHub is now fully installed and ready to use anywhere!

---

## 🚀 Command Usage

### Basic Commands
```bash
novahub                    # Start NovaHub TUI (Terminal UI)
novahub --version          # Show version
novahub --help             # Show help
novahub run "your query"   # Run with direct message
```

### Advanced Commands
```bash
novahub web                # Start web interface
novahub serve              # Start headless server
novahub auth               # Manage credentials
novahub models             # List available AI models
novahub session            # Manage sessions
novahub agent              # Manage agents
```

### Development
```bash
novahub debug              # Debug tools
novahub stats              # Token usage stats
novahub completion         # Shell completion
```

---

## 📍 Important Locations

- **Binary:** `~/NovaHub/packages/novahub/dist/novahub-linux-x64/bin/novahub`
- **Wrapper:** `~/.local/bin/novahub` (what gets called)
- **Config:** `~/.novahub/`
- **Source:** `~/NovaHub/`

---

## ⚙️ Configuration

Default config location: `~/.novahub/novahub.jsonc`

---

## 🔧 Troubleshooting

### Command not found
```bash
# Ensure ~/.local/bin is in PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Rebuild if needed
```bash
cd ~/NovaHub/packages/novahub
export PATH="$HOME/.bun/bin:$PATH"
bun run script/build.ts
```

### Update wrapper
```bash
cat > ~/.local/bin/novahub << 'EOF'
#!/bin/bash
export PATH="$HOME/.bun/bin:$PATH"
exec "$HOME/NovaHub/packages/novahub/dist/novahub-linux-x64/bin/novahub" "$@"
EOF
chmod +x ~/.local/bin/novahub
```

---

## 📊 Version Info

- **Current:** 0.0.0-master-202602010604
- **Base:** OpenCode 1.1.48
- **Released:** 2026-02-01

---

## 🎨 Branding

**ASCII Art:** Shows "NovaHub" ✅  
**Command name:** `novahub` ✅  
**Help text:** All updated ✅  
**Copyright:** WeNova Interactive ✅  

---

## 🌟 Features

All OpenCode features available:
- ✅ AI-powered coding assistance
- ✅ Multiple AI providers
- ✅ Terminal UI (TUI)
- ✅ Web interface
- ✅ Session management
- ✅ Plugin system
- ✅ GitHub integration
- ✅ Agent system
- ✅ Tool execution

---

## 📚 Documentation

- `BUILD_SUCCESS.md` - Build summary
- `VERSION.md` - Version tracking
- `REBRAND_SUMMARY.md` - What changed
- `QUICK_START.md` - Setup guide
- `README.md` - Main documentation

---

**Created by:** MrNova420 | WeNova Interactive  
**Based on:** OpenCode (MIT License)  
**Your hub for development!** 🌟
