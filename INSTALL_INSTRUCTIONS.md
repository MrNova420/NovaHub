# NovaHub Installation - Super Simple!

## One Command Install (Recommended)

Just like OpenCode, everything is automatic:

```bash
curl -fsSL https://raw.githubusercontent.com/MrNova420/NovaHub/master/install.sh | bash
```

**That's it!** The installer automatically:
1. ✅ Checks requirements (git, curl, bun)
2. ✅ Installs Bun if needed
3. ✅ Clones NovaHub repository
4. ✅ Installs dependencies
5. ✅ Builds binaries
6. ✅ **Installs Ollama (Local AI)**
7. ✅ **Downloads qwen2.5-coder:7b model (4.7GB)**
8. ✅ Sets up global `novahub` command
9. ✅ Configures everything

Then just run:
```bash
novahub
```

---

## What You Get Out of the Box

✅ **NovaHub CLI** - Fully working  
✅ **Local AI** - Ollama with default model  
✅ **No API Keys** - Works offline  
✅ **Global Command** - Run `novahub` anywhere  
✅ **All Docs** - Complete documentation  

---

## Alternative: Manual Install (If You Already Cloned)

If you already have the repo:

```bash
cd ~/NovaHub
./install.sh
```

This runs the same automatic installer.

---

## Skip Ollama (Optional)

If you don't want local AI (not recommended):

```bash
# Edit install.sh and set:
INSTALL_OLLAMA=false

# Then run:
./install.sh
```

---

## After Installation

```bash
# Start NovaHub
novahub

# In the TUI:
# - Press Tab to see providers
# - Ollama appears first (local AI)
# - Select a model and start coding!
```

---

## Managing Models

```bash
# List installed models
ollama list

# Download more models
ollama pull phi3:mini              # 2.3GB - Lightweight
ollama pull deepseek-coder-v2:16b  # 9GB - Powerful
ollama pull codellama:13b          # 7.4GB - Meta

# Remove models
ollama rm <model-name>

# Test a model
ollama run qwen2.5-coder:7b
```

---

## What install.sh Does

```bash
[INFO] Checking system requirements...
[✓] OS: Linux
[✓] git is installed
[✓] curl is installed

[→] Installing Bun...
[✓] Bun installed: 1.3.8

[→] Cloning NovaHub repository...
[✓] Repository cloned

[→] Installing dependencies...
[✓] 3,568 packages installed

[→] Building NovaHub...
[✓] Built 11 platform binaries

[→] Installing Ollama (Local AI)...
[✓] Ollama installed

[→] Downloading default model (qwen2.5-coder:7b - 4.7GB)...
[✓] Model downloaded

[→] Setting up global command...
[✓] novahub command available

╔══════════════════════════════════════════════════════╗
║     NovaHub Installation Complete! 🎉                ║
╚══════════════════════════════════════════════════════╝

Installed:
  ✓ NovaHub CLI (v0.0.1)
  ✓ Local AI (Ollama + qwen2.5-coder:7b)
  ✓ Global command

Get Started:
  novahub              - Start NovaHub
  novahub --help       - Show help
  ollama list          - List models

Documentation:
  ~/NovaHub/README_QUICK.md
  ~/NovaHub/DOCUMENTATION.md
  ~/NovaHub/OLLAMA_SETUP.md

Happy coding! 🚀
```

---

## Troubleshooting

### Installation fails?
```bash
# Check logs
cat ~/NovaHub/install.log

# Or run with verbose:
bash -x install.sh
```

### Ollama doesn't work?
```bash
# Manually start Ollama
ollama serve

# In another terminal:
novahub
```

### Model download too slow?
```bash
# The 4.7GB download might take a while
# You can skip it and download later:
ollama pull qwen2.5-coder:7b
```

---

## No Separate Setup Needed!

❌ **Don't need to run:** `./SETUP_OLLAMA.sh`  
✅ **Just run:** `./install.sh` or the curl command

Everything is automated, just like OpenCode! 🎉

---

## System Requirements

- **OS:** Linux or macOS
- **RAM:** 8GB minimum, 16GB recommended
- **Disk:** ~10GB free (NovaHub + Ollama + model)
- **Tools:** git, curl (auto-checked by installer)

---

**Ready to install?**

```bash
curl -fsSL https://raw.githubusercontent.com/MrNova420/NovaHub/master/install.sh | bash
```

Then:

```bash
novahub
```

That's it! 🚀
