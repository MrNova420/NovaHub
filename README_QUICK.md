# NovaHub - Quick Start

**Your Central Development Hub with Local AI**

Version: 0.0.1 → 0.1.0 (in progress)  
By: MrNova420 | WeNova Interactive

---

## 🚀 Get Started in 3 Steps

### 1. Install Ollama (Local AI)
```bash
cd ~/NovaHub
./SETUP_OLLAMA.sh
```
*Requires sudo password. Downloads 4.7GB model.*

### 2. Launch NovaHub
```bash
novahub
```

### 3. Start Coding!
- Press `Tab` to select provider
- Choose "Ollama" (first in list)
- Start chatting with your local AI

---

## ✨ Features

✅ **Works Offline** - Local AI, no internet needed  
✅ **No API Keys** - Completely free to use  
✅ **Private** - Code never leaves your machine  
✅ **Fast** - No network latency  
✅ **Easy** - One command to start  

---

## 📚 Documentation

- **STATUS.md** - Current status and next steps
- **OLLAMA_SETUP.md** - Detailed Ollama guide
- **AI_MODEL_BUNDLING_PLAN.md** - Future plans for bundled models
- **PROVIDER_CLEANUP.md** - Provider list improvements
- **DOCUMENTATION.md** - Full user guide

---

## 🔧 Commands

```bash
novahub              # Start TUI
novahub --help       # Show help
novahub --version    # Show version

# Model management
ollama list          # Show downloaded models
ollama pull <model>  # Download a model
ollama rm <model>    # Remove a model
```

---

## 🤖 Available Models

After running SETUP_OLLAMA.sh:
- ✅ **qwen2.5-coder:7b** (4.7GB) - Default, great for coding

To download more:
```bash
ollama pull phi3:mini              # 2.3GB - Lightweight
ollama pull deepseek-coder-v2:16b  # 9GB - Most powerful
ollama pull codellama:13b          # 7.4GB - Meta's model
ollama pull llama3.1:8b            # 4.7GB - General purpose
```

---

## 🎯 What's Next?

### Completed Today ✅
- Logo fixed (no cutoff)
- Provider list cleaned up
- Ollama configuration ready
- Setup script created
- Comprehensive docs written

### Testing Now 🔄
- Install Ollama
- Test provider selection
- Verify models work
- Check logo display

### Coming Soon ⏳
- Bundle 2-6GB model with installer
- Show model sizes in UI
- Model management interface
- Custom fine-tuned model

---

## 💡 Tips

- **For 8GB RAM:** Use `phi3:mini` (faster)
- **For 16GB RAM:** Use `qwen2.5-coder:7b` (recommended)
- **For 32GB+ RAM:** Use `deepseek-coder-v2:16b` (most powerful)

---

## 🐛 Troubleshooting

### "Ollama not found"
```bash
./SETUP_OLLAMA.sh
```

### "No models available"
```bash
ollama pull qwen2.5-coder:7b
```

### Logo still cut off
```bash
# Check terminal size
echo $COLUMNS $LINES
# Resize terminal if too small
```

---

## 📞 Support

- Issues: Create issue on GitHub
- Docs: See DOCUMENTATION.md
- Config: ~/.novahub/novahub.jsonc

---

**Ready to code with local AI!** 🎉

Run: `./SETUP_OLLAMA.sh` then `novahub`
