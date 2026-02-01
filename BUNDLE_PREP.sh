#!/usr/bin/env bash
#
# NovaHub Bundle Prep - Extract model before bundling
# Run this once with sudo to extract the model
#

set -e

echo "Extracting Qwen 3B model from Ollama storage..."

MODEL_SHA=$(ollama show qwen2.5-coder:3b --modelfile | grep "^FROM" | awk '{print $2}' | xargs basename)

if [ -z "$MODEL_SHA" ]; then
    echo "Error: Could not get model SHA"
    exit 1
fi

echo "Model SHA: $MODEL_SHA"

if [ ! -f "/usr/share/ollama/.ollama/models/blobs/$MODEL_SHA" ]; then
    echo "Error: Model blob not found at /usr/share/ollama/.ollama/models/blobs/$MODEL_SHA"
    exit 1
fi

echo "Copying model to /tmp/qwen-3b-model.gguf ..."
sudo cp "/usr/share/ollama/.ollama/models/blobs/$MODEL_SHA" "/tmp/qwen-3b-model.gguf"
sudo chown $(whoami):$(whoami) "/tmp/qwen-3b-model.gguf"

SIZE=$(du -h /tmp/qwen-3b-model.gguf | cut -f1)
echo "✓ Model extracted: /tmp/qwen-3b-model.gguf ($SIZE)"
echo ""
echo "Now you can run ./create-bundles.sh without sudo!"
