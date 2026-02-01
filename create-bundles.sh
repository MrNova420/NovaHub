#!/usr/bin/env bash
#
# NovaHub Bundling Script - Create Release Bundles
# Creates platform-specific bundles with Ollama + Qwen 3B model
#

set -e

VERSION="0.2.0"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUNDLE_DIR="$SCRIPT_DIR/bundles"
NOVAHUB_DIR="$SCRIPT_DIR"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Banner
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  NovaHub v$VERSION - Bundle Creator                      ║"
echo "║  Creates platform bundles with Ollama + AI model        ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check prerequisites
log "Checking prerequisites..."

if ! command -v ollama &> /dev/null; then
    warn "Ollama not found. Install with: curl -fsSL https://ollama.com/install.sh | sh"
    exit 1
fi
success "Ollama found"

if ! command -v bun &> /dev/null; then
    warn "Bun not found. Install with: curl -fsSL https://bun.sh/install | bash"
    exit 1
fi
success "Bun found"

# Check if 3B model exists
log "Checking for Qwen 3B model..."
if ! ollama list | grep -q "qwen2.5-coder:3b"; then
    warn "Qwen 3B model not found. Downloading..."
    ollama pull qwen2.5-coder:3b
fi
success "Qwen 3B model ready"

# Build NovaHub binaries
log "Building NovaHub binaries..."
cd "$NOVAHUB_DIR/packages/novahub"
bun run build
success "NovaHub binaries built"

# Create bundle directory
rm -rf "$BUNDLE_DIR"
mkdir -p "$BUNDLE_DIR"

# Function to create bundle for a platform
create_bundle() {
    local platform=$1
    local arch=$2
    local ollama_binary=$3
    
    log "Creating bundle for $platform-$arch..."
    
    local bundle_name="novahub-v${VERSION}-${platform}-${arch}-bundle"
    local bundle_path="$BUNDLE_DIR/$bundle_name"
    
    mkdir -p "$bundle_path"/{bin,models,config}
    
    # Copy NovaHub binary
    if [ -d "$NOVAHUB_DIR/packages/novahub/dist/novahub-$platform-$arch" ]; then
        cp -r "$NOVAHUB_DIR/packages/novahub/dist/novahub-$platform-$arch/bin/novahub" "$bundle_path/bin/"
        chmod +x "$bundle_path/bin/novahub"
    else
        warn "NovaHub binary not found for $platform-$arch, skipping..."
        return
    fi
    
    # Download Ollama binary if needed
    if [ ! -f "/tmp/ollama-$ollama_binary" ]; then
        log "Downloading Ollama binary for $platform..."
        curl -L "https://github.com/ollama/ollama/releases/latest/download/ollama-$ollama_binary" \
            -o "/tmp/ollama-$ollama_binary"
        chmod +x "/tmp/ollama-$ollama_binary"
    fi
    cp "/tmp/ollama-$ollama_binary" "$bundle_path/bin/ollama"
    
    # Copy Qwen 3B model
    log "Copying Qwen 3B model..."
    local model_path=$(find ~/.ollama/models -name "sha256-*" | head -1)
    if [ -n "$model_path" ]; then
        cp "$model_path" "$bundle_path/models/qwen2.5-coder-3b.gguf"
    else
        warn "Model file not found, bundle may be incomplete"
    fi
    
    # Copy config
    cp "$NOVAHUB_DIR/.novahub/novahub.jsonc" "$bundle_path/config/"
    
    # Create tarball
    log "Creating compressed archive..."
    cd "$BUNDLE_DIR"
    tar -czf "${bundle_name}.tar.gz" "$bundle_name"
    rm -rf "$bundle_name"
    
    local size=$(du -h "${bundle_name}.tar.gz" | cut -f1)
    success "Created ${bundle_name}.tar.gz ($size)"
}

# Create bundles for each platform
log "Creating platform bundles..."
echo ""

create_bundle "linux" "x64" "linux-amd64"
create_bundle "linux" "arm64" "linux-arm64"
create_bundle "darwin" "arm64" "darwin"
create_bundle "darwin" "x64" "darwin"

echo ""
success "All bundles created!"
echo ""

# Summary
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Bundle Summary                                          ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

cd "$BUNDLE_DIR"
ls -lh *.tar.gz | awk '{print "  • " $9 " - " $5}'

echo ""
echo "Next steps:"
echo "  1. Test bundles on clean systems"
echo "  2. Create GitHub Release v$VERSION"
echo "  3. Upload bundles as release assets:"
echo ""
echo "     gh release create v$VERSION \\"
echo "       --title \"NovaHub v$VERSION - Bundled with Local AI\" \\"
echo "       --notes \"Includes Ollama + Qwen 3B (2GB) model\" \\"
for bundle in *.tar.gz; do
    echo "       $bundle \\"
done | sed '$ s/ \\$//'
echo ""
