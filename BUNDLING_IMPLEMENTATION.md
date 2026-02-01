# Bundling Ollama + Model with NovaHub

**Goal:** Bundle Ollama binary + AI model (2-6GB) directly with NovaHub installer
- No separate downloads during installation
- Everything in one package
- Works offline immediately after install
- Just like apps that come with everything included

---

## Current State (v0.0.1)

❌ **Problem:** installer downloads separately:
1. Downloads NovaHub (~200MB)
2. Downloads Ollama (~50MB) 
3. Downloads model (~4.7GB)
4. Total: ~5GB download DURING install

⏱️ Takes time, requires internet during install

---

## Target State (v0.2.0)

✅ **Solution:** Bundle everything together:
1. Single download: NovaHub + Ollama + Model (~5-7GB total)
2. Installer just extracts/sets up
3. Works offline immediately
4. No waiting during install

---

## Implementation Approach

### Option 1: Include in Git Repo (Not Recommended)
```
NovaHub/
├── packages/
├── bundled/
│   ├── ollama-binary/
│   │   ├── ollama-linux-x64
│   │   ├── ollama-linux-arm64
│   │   ├── ollama-darwin-x64
│   │   └── ollama-darwin-arm64
│   └── models/
│       └── qwen2.5-coder-3b.gguf (2GB)
```

❌ **Cons:**
- Git repo becomes huge (2-5GB+)
- Slow clones
- Not ideal for git

### Option 2: Release Assets (RECOMMENDED) ✅
```
GitHub Release: NovaHub v0.2.0
Assets:
├── novahub-linux-x64-bundle.tar.gz (2.5GB)
│   ├── novahub binary
│   ├── ollama binary  
│   └── qwen2.5-coder-3b.gguf
├── novahub-darwin-arm64-bundle.tar.gz (2.5GB)
│   └── ...
└── install.sh (detects platform, downloads correct bundle)
```

✅ **Pros:**
- Clean git repo (stays small)
- Platform-specific bundles
- Easy updates
- Standard practice

### Option 3: Separate Download Server
```
https://downloads.novahub.dev/
├── v0.2.0/
│   ├── linux-x64-bundle.tar.gz
│   ├── darwin-arm64-bundle.tar.gz
│   └── models/
│       └── qwen-3b.gguf
```

✅ **Pros:**
- Full control
- Fast CDN
- Can host anywhere

❌ **Cons:**
- Need hosting
- Need CDN setup

---

## Recommended: GitHub Releases + Smart Installer

### Package Structure:
```
novahub-v0.2.0-linux-x64-bundle.tar.gz (2.5GB)
└── novahub-bundle/
    ├── bin/
    │   ├── novahub          # NovaHub CLI binary
    │   └── ollama           # Ollama binary
    ├── models/
    │   └── qwen2.5-coder-3b.gguf  # Small model (2GB)
    └── config/
        └── novahub.jsonc    # Pre-configured
```

### Smart Installer Flow:
```bash
# 1. Detect platform
PLATFORM="linux-x64"  # or darwin-arm64, etc.

# 2. Download bundle from GitHub Release
curl -L https://github.com/MrNova420/NovaHub/releases/download/v0.2.0/novahub-$PLATFORM-bundle.tar.gz \
  -o novahub-bundle.tar.gz

# 3. Extract
tar -xzf novahub-bundle.tar.gz

# 4. Install
cp novahub-bundle/bin/novahub ~/.local/bin/
cp novahub-bundle/bin/ollama ~/.local/bin/
mkdir -p ~/.ollama/models/
cp novahub-bundle/models/* ~/.ollama/models/
cp novahub-bundle/config/* ~/.novahub/

# 5. Done! No downloads needed
novahub --version
```

---

## Model Selection for Bundling

### Best Candidates (2-3GB range):

#### 🥇 Qwen2.5-Coder 3B (2GB) - RECOMMENDED
```
Size: ~2GB GGUF Q4_K_M
Performance: Excellent for coding
Speed: Fast on CPU
Context: 32K tokens
License: Apache 2.0 ✓
```

#### 🥈 Phi-3 Mini (2.3GB) - Alternative
```
Size: 2.3GB
Performance: Good, Microsoft-backed
Speed: Very fast
Context: 4K tokens
License: MIT ✓
```

#### 🥉 DeepSeek-Coder 1.3B (800MB) - Lightweight Option
```
Size: 800MB
Performance: Surprisingly good
Speed: Ultra fast
Context: 16K tokens
License: Apache 2.0 ✓
```

**Recommendation:** Bundle Qwen2.5-Coder 3B (best quality/size ratio)

---

## Implementation Steps

### Phase 1: Create Bundles (Week 1)

```bash
# 1. Download Ollama binaries
wget https://github.com/ollama/ollama/releases/download/v0.x.x/ollama-linux-amd64
wget https://github.com/ollama/ollama/releases/download/v0.x.x/ollama-darwin

# 2. Download model (use Ollama to get GGUF)
ollama pull qwen2.5-coder:3b
# Model is in ~/.ollama/models/

# 3. Build NovaHub binaries (already done)
cd packages/novahub
bun run build

# 4. Create bundle structure
mkdir -p bundle/bin bundle/models bundle/config

# 5. Copy files
cp dist/novahub-linux-x64/bin/novahub bundle/bin/
cp ollama-linux-amd64 bundle/bin/ollama
cp ~/.ollama/models/blobs/sha256-xxx bundle/models/qwen2.5-coder-3b.gguf
cp .novahub/novahub.jsonc bundle/config/

# 6. Create tarball
tar -czf novahub-v0.2.0-linux-x64-bundle.tar.gz bundle/

# 7. Upload to GitHub Release
gh release create v0.2.0 \
  --title "NovaHub v0.2.0 - Bundled with Local AI" \
  --notes "Includes Ollama + Qwen 3B model" \
  novahub-v0.2.0-linux-x64-bundle.tar.gz
```

### Phase 2: Update Installer (Week 1)

```bash
#!/bin/bash
# New install.sh

VERSION="0.2.0"
PLATFORM=$(detect_platform)  # linux-x64, darwin-arm64, etc.
BUNDLE_URL="https://github.com/MrNova420/NovaHub/releases/download/v${VERSION}/novahub-${PLATFORM}-bundle.tar.gz"

# Download bundle (ONE download, everything included)
curl -L $BUNDLE_URL -o novahub-bundle.tar.gz

# Extract
tar -xzf novahub-bundle.tar.gz

# Install
install_bundle

# Done!
echo "NovaHub installed with local AI - ready to use offline!"
```

### Phase 3: Test (Week 2)

```bash
# Test on clean system
docker run -it ubuntu:22.04
curl -fsSL https://raw.githubusercontent.com/MrNova420/NovaHub/master/install.sh | bash

# Should work completely offline after initial download
# No separate downloads
# No waiting for model downloads
```

### Phase 4: Release (Week 2)

```bash
# Tag and release
git tag v0.2.0
git push origin v0.2.0

# Upload bundles to GitHub Release
# Update docs
# Announce
```

---

## Bundle Sizes

### Per Platform:

```
NovaHub binary:        ~40MB
Ollama binary:         ~50MB
Qwen 3B model:         ~2GB
Config/docs:           ~5MB
─────────────────────────────
Total per platform:    ~2.1GB

Compressed (tar.gz):   ~1.8GB
```

### All Platforms:

```
linux-x64:            1.8GB
linux-arm64:          1.8GB
darwin-x64:           1.8GB
darwin-arm64:         1.8GB
windows-x64:          1.9GB
─────────────────────────────
Total (5 platforms):  ~9GB
```

### Storage:
- GitHub Releases: Free for open source (no limit on release assets)
- Or use: DigitalOcean Spaces, AWS S3, Cloudflare R2

---

## User Experience

### Before (v0.0.1):
```bash
$ curl install.sh | bash
Downloading NovaHub... [200MB]
Installing Bun...
Installing Ollama... [50MB download]
Downloading model... [4.7GB download] ← SLOW!
Building...
Done! (15-30 minutes)
```

### After (v0.2.0):
```bash
$ curl install.sh | bash
Downloading NovaHub bundle... [1.8GB]
Extracting...
Installing...
Done! (5 minutes)

$ novahub
# Works immediately, no setup!
```

---

## Alternative: Hybrid Approach

Bundle small model (2GB), offer larger models as optional downloads:

```bash
# Bundled (automatic):
✓ Qwen 3B (2GB) - Installed

# Optional (manual download):
○ Qwen 7B (4.7GB)
○ DeepSeek 16B (9GB)
○ CodeLlama 13B (7.4GB)

# User can download more via:
ollama pull <model>
```

✅ **Best of both worlds:**
- Fast install (2GB bundle)
- Works immediately
- Can upgrade later

---

## Implementation Priority

### v0.2.0 - Basic Bundling
- [x] Plan architecture (this doc)
- [ ] Download Qwen 3B model
- [ ] Get Ollama binaries for all platforms
- [ ] Create bundle scripts
- [ ] Update installer
- [ ] Test on clean systems
- [ ] Create GitHub Release with bundles
- [ ] Update docs

### v0.3.0 - Enhanced
- [ ] Bundle selector (small/medium/large)
- [ ] Resume downloads
- [ ] Torrent option for large bundles
- [ ] Mirror servers

### v1.0.0 - Production
- [ ] Custom fine-tuned NovaHub model
- [ ] Auto-updates
- [ ] Smart model switching
- [ ] CDN distribution

---

## Next Steps

1. **Download and prepare model**
   ```bash
   ollama pull qwen2.5-coder:3b
   # Find GGUF file in ~/.ollama/models/
   ```

2. **Get Ollama binaries**
   ```bash
   # Download from GitHub releases for all platforms
   ```

3. **Create packaging script**
   ```bash
   # Script to create bundles automatically
   ```

4. **Test locally**
   ```bash
   # Verify bundle works on your system
   ```

5. **Create GitHub Release**
   ```bash
   # Upload bundles as release assets
   ```

---

## Summary

✅ **Goal:** Bundle everything in one download  
✅ **Method:** GitHub Releases with platform-specific bundles  
✅ **Size:** ~1.8-2GB per platform (compressed)  
✅ **Model:** Qwen2.5-Coder 3B (2GB, excellent quality)  
✅ **Result:** One download, works offline immediately  

**Target Release:** v0.2.0 (2 weeks)

---

Let's make NovaHub the easiest AI coding assistant to install! 🚀
