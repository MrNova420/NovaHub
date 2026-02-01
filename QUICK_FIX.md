# Quick Fix for Ollama Install

The installer needs `zstd` package. Just run these commands:

```bash
# Install zstd (enter your password when prompted)
sudo apt-get update
sudo apt-get install -y zstd

# Then re-run installer
cd ~/NovaHub
./install.sh
```

That's it! The installer will then:
- Install Ollama ✓
- Download qwen2.5-coder:7b model (4.7GB)
- Complete setup

Then you can run:
```bash
novahub
```

---

**Or skip Ollama for now:**

If you want to use NovaHub without local AI (you can add it later):

```bash
# NovaHub already works!
novahub --version
novahub
```

You can add cloud providers (Anthropic, OpenAI, etc.) or install Ollama later.
