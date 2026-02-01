# NovaHub Bundling Status

**Last Updated:** 2026-02-01  
**Status:** 🔧 WORK IN PROGRESS

---

## Overview

Goal: Create platform-specific bundles containing:
- NovaHub binary (~38MB)
- Ollama binary (~500MB)
- Qwen 3B model (~1.9GB)
- Config files

**Target:** Single downloadable archive per platform (~2.3GB)

---

## Current Status

### ✅ What's Working
1. **Bundle Script Framework**
   - `create-bundles.sh` - Main bundling script
   - `BUNDLE_PREP.sh` - Model extraction helper
   - Platform detection
   - Directory structure creation

2. **NovaHub Binaries**
   - All 11 platform binaries built
   - Successfully copied to bundle directories

3. **Ollama Binary Downloads**
   - Fixed download URLs for all platforms:
     - Linux x64: `ollama-linux-amd64.tgz`
     - Linux arm64: `ollama-linux-arm64.tgz`
     - macOS: `ollama-darwin`

4. **Config Files**
   - Config structure prepared
   - Templates ready for bundling

### ❌ What's Blocked

**CRITICAL ISSUE:** Model file extraction not working

**Problem:**
```bash
ollama show qwen2.5-coder:3b --modelfile
# Reports: FROM /usr/share/ollama/.ollama/models/blobs/sha256-4a188102...

# But file doesn't exist:
ls /usr/share/ollama/.ollama/models/blobs/
# Error: No such file or directory
```

**Attempted Solutions:**
1. ❌ Copy from `/usr/share/ollama/` - doesn't exist
2. ❌ Copy from `~/.ollama/models/` - doesn't exist
3. ❌ Copy from `/var/lib/ollama/` - not accessible

**Theory:**
- Ollama may be using a virtual file system
- Model might be stored in a database/registry
- Files might be stored elsewhere with symlinks
- Need to investigate Ollama internals

---

## Current Bundle Sizes

**Actual (incomplete):**
- linux-x64: 49MB
- linux-arm64: 48MB  
- darwin-arm64: 33MB
- darwin-x64: 34MB

**Expected (complete):**
- All platforms: ~2.3GB each

**Missing:** ~2GB model file per bundle

---

## Workaround: Use Installer

**Recommended Approach:**

Instead of bundled archives, use the installer:
```bash
curl -fsSL https://raw.githubusercontent.com/[repo]/install.sh | bash
```

**Why Installer Works:**
- Ollama installs itself properly
- Downloads model on first run
- Handles all permissions
- No file extraction issues
- Simpler maintenance

**Benefits:**
- ✅ Smaller download (no 2GB model)
- ✅ Always gets latest model
- ✅ Handles system-specific quirks
- ✅ No sudo password prompts
- ✅ Proven to work

---

## Next Steps to Fix Bundling

### Investigation Needed
1. **Ollama Storage Mechanism**
   - Read Ollama source code
   - Understand model storage format
   - Find actual file locations

2. **Alternative Approaches**
   - Export model using Ollama API
   - Create custom model package
   - Use Ollama's own export tools

3. **Test on Clean System**
   - Fresh Ollama install
   - Track where files go
   - Document actual paths

### Code Changes Needed
1. Update `BUNDLE_PREP.sh`:
   - Find correct model path
   - Handle permissions properly
   - Verify file exists before copy

2. Update `create-bundles.sh`:
   - Use extracted model from prep
   - Add verification steps
   - Test bundle extraction

---

## Timeline

### v0.1.0 (Now)
- ✅ Ship with installer approach
- ✅ Proven to work
- ✅ Ready for production use

### v0.2.0 (Later)
- 🔧 Fix model extraction
- 🔧 Complete bundling
- 🔧 Test on multiple systems
- 🔧 Create GitHub releases

### v0.3.0 (Future)
- 📦 Automated bundle creation
- 📦 CI/CD integration
- 📦 Multiple model options

---

## Scripts Reference

### create-bundles.sh
**Purpose:** Create platform bundles  
**Status:** 90% complete  
**Blocked:** Model file access

**Usage:**
```bash
./create-bundles.sh
```

### BUNDLE_PREP.sh
**Purpose:** Extract model file once (with sudo)  
**Status:** Not working yet  
**Issue:** Model path incorrect

**Usage:**
```bash
./BUNDLE_PREP.sh  # Needs fixing first
```

### install.sh
**Purpose:** Install NovaHub with Ollama  
**Status:** ✅ 100% working  
**Recommended:** YES

**Usage:**
```bash
./install.sh
```

---

## Conclusion

**Bundling is a "nice to have" not a "must have"**

The installer approach works perfectly and is actually better for most use cases:
- Smaller downloads
- Always fresh models
- Handles system differences
- Easier maintenance

**Recommendation:** Ship v0.1.0 with installer, revisit bundling in v0.2.0+ when we have time to properly investigate Ollama's storage mechanism.

---

**Bottom Line:** Don't let bundling block the release. The installer is production-ready! 🚀
