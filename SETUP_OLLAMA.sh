#!/usr/bin/env bash
# NovaHub - Ollama Setup Script
# Installs Ollama and downloads recommended models

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  NovaHub - Local AI Setup with Ollama                       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check if Ollama is already installed
if command -v ollama &> /dev/null; then
    echo "✓ Ollama is already installed"
    ollama --version
else
    echo "Installing Ollama..."
    echo "This will require sudo password for installation."
    echo ""
    curl -fsSL https://ollama.com/install.sh | sh
    echo ""
    echo "✓ Ollama installed successfully!"
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "Downloading default model: qwen2.5-coder:7b (4.7GB)"
echo "This is a great coding model that works well on most hardware."
echo "════════════════════════════════════════════════════════════════"
echo ""

# Download default model
if ollama list | grep -q "qwen2.5-coder:7b"; then
    echo "✓ qwen2.5-coder:7b already downloaded"
else
    echo "Downloading qwen2.5-coder:7b..."
    ollama pull qwen2.5-coder:7b
    echo ""
    echo "✓ qwen2.5-coder:7b downloaded successfully!"
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "✓ Local AI Setup Complete!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Your downloaded models:"
ollama list
echo ""
echo "To download more models, run:"
echo "  ollama pull <model-name>"
echo ""
echo "Popular coding models:"
echo "  • phi3:mini (2.3GB) - Lightweight, fast"
echo "  • deepseek-coder-v2:16b (9GB) - Powerful"
echo "  • codellama:13b (7.4GB) - Meta's model"
echo "  • llama3.1:8b (4.7GB) - General purpose"
echo ""
echo "Now run: novahub"
echo ""
