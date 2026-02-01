# NovaHub Local AI Setup Guide

## What is Ollama?

**Ollama** is a tool that lets you run AI models **locally on your computer**. Think of it like this:

- **Ollama** = The engine/runtime (like Docker for AI models)
- **Models** = The actual AI brains you download (like qwen2.5-coder, llama3, etc.)

### Why Use Ollama with NovaHub?

✅ **No API Keys** - Works completely offline  
✅ **Private** - Your code never leaves your machine  
✅ **Free** - No usage costs or limits  
✅ **Fast** - No network latency  
✅ **Many Models** - Tons of options to choose from

---

## Quick Setup (3 Steps)

### 1. Install Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### 2. Download a Model

```bash
# Best for coding (recommended):
ollama pull qwen2.5-coder:7b

# Or try others:
ollama pull deepseek-coder-v2:16b  # More powerful
ollama pull codellama:13b           # Meta's model
ollama pull llama3.1:8b             # General purpose
```

### 3. Start NovaHub

```bash
novahub
```

That's it! NovaHub will automatically use Ollama.

---

## How It Works in NovaHub

When you run `novahub`:

1. **If Ollama is installed**: You'll see Ollama models in the provider list
2. **If a model is pulled**: It works immediately, no setup!
3. **If no model**: NovaHub will guide you to download one

### In the TUI:

- Press `Tab` to see providers
- Select "Ollama" from the list
- Choose from your downloaded models
- Start coding!

---

## Popular Models for Coding

| Model | Size | Best For | Speed |
|-------|------|----------|-------|
| **qwen2.5-coder:7b** | 4.7GB | General coding | ⚡⚡⚡ Fast |
| **deepseek-coder-v2:16b** | 9GB | Complex tasks | ⚡⚡ Medium |
| **codellama:13b** | 7.4GB | Code generation | ⚡⚡ Medium |
| **llama3.1:8b** | 4.7GB | General purpose | ⚡⚡⚡ Fast |
| **phi3:mini** | 2.3GB | Quick tasks | ⚡⚡⚡⚡ Very Fast |

### Download Any Model:

```bash
# See all available models:
ollama list

# Pull a specific model:
ollama pull <model-name>

# Example:
ollama pull qwen2.5-coder:7b
```

---

## Ollama Commands

### Manage Models
```bash
ollama list                 # Show downloaded models
ollama pull <model>         # Download a model
ollama rm <model>          # Remove a model
ollama run <model>         # Test a model in chat
```

### Service Management
```bash
ollama serve               # Start Ollama server
systemctl status ollama    # Check if running (Linux)
```

### Model Information
```bash
ollama show <model>        # Show model details
ollama ps                  # Show running models
```

---

## NovaHub Configuration

Your config is at: `~/.novahub/novahub.jsonc`

### Default Setup:
```jsonc
{
  "model": "ollama/qwen2.5-coder:7b",
  "provider": {
    "ollama": {
      "url": "http://localhost:11434"
    }
  }
}
```

### Change Default Model:
```jsonc
{
  "model": "ollama/deepseek-coder-v2:16b"
}
```

### Use Multiple Providers:
```jsonc
{
  "model": "ollama/qwen2.5-coder:7b",  // Default
  "provider": {
    "ollama": {
      "url": "http://localhost:11434"
    },
    "anthropic": {
      "apiKey": "your-key"  // Optional: Add external providers
    }
  }
}
```

---

## Troubleshooting

### "Ollama not found"
```bash
# Install Ollama:
curl -fsSL https://ollama.com/install.sh | sh

# Verify:
ollama --version
```

### "No models available"
```bash
# Download a model first:
ollama pull qwen2.5-coder:7b

# Check what you have:
ollama list
```

### "Connection refused"
```bash
# Start Ollama service:
ollama serve

# Or check if it's running:
curl http://localhost:11434/api/tags
```

### "Model too slow"
- Try a smaller model (phi3:mini is 2.3GB)
- Close other apps to free RAM
- Use GPU if available (automatic with Ollama)

---

## Model Recommendations by Hardware

### 8GB RAM
- **phi3:mini** (2.3GB) - Best choice
- **llama3.1:8b** (4.7GB) - Good balance
- **qwen2.5-coder:7b** (4.7GB) - Great for coding

### 16GB RAM
- **qwen2.5-coder:7b** (4.7GB) - Recommended
- **codellama:13b** (7.4GB) - Excellent
- **deepseek-coder-v2:16b** (9GB) - Most powerful

### 32GB+ RAM
- **Any model works great!**
- Try larger models for better results
- Run multiple models simultaneously

---

## Advanced: Multiple Ollama Instances

You can run Ollama on different ports:

```bash
# Start on custom port:
OLLAMA_HOST=0.0.0.0:11435 ollama serve

# In NovaHub config:
{
  "provider": {
    "ollama-local": {
      "url": "http://localhost:11434"
    },
    "ollama-remote": {
      "url": "http://server:11435"
    }
  }
}
```

---

## Integration in NovaHub

NovaHub automatically:
1. ✅ Detects if Ollama is installed
2. ✅ Shows available Ollama models in the TUI
3. ✅ Uses default model from config
4. ✅ Falls back to online providers if Ollama not available
5. ✅ Lets you switch between models with Tab key

---

## FAQ

**Q: Do I need internet?**  
A: Only to download models. After that, 100% offline!

**Q: How much disk space?**  
A: Models range from 2GB to 10GB+ each.

**Q: Can I use my GPU?**  
A: Yes! Ollama automatically uses GPU if available.

**Q: Which model is best?**  
A: For coding: `qwen2.5-coder:7b` - great balance of speed and quality.

**Q: Can I use other providers too?**  
A: Yes! NovaHub supports multiple providers simultaneously.

**Q: Is it really free?**  
A: Yes! Ollama and all models are completely free and open source.

---

## Resources

- **Ollama Website**: https://ollama.com
- **Model Library**: https://ollama.com/library
- **NovaHub Docs**: `~/NovaHub/DOCUMENTATION.md`
- **Config File**: `~/.novahub/novahub.jsonc`

---

**Ready to code with local AI!** 🚀

Run: `novahub` and start building!
