# NovaHub Changelog

All notable changes to this project will be documented in this file.

## [0.2.0] - 2026-02-01 (In Progress)

### 🎯 Critical Fixes
- **Eliminated AI mode instruction spam** that caused response loops
  - Removed 69 lines of READ-ONLY warnings from Plan mode
  - Removed all Build mode reminders
  - Modified `packages/novahub/src/session/prompt.ts` to skip mode injection
  - AI now responds naturally without repeating mode rules

### ⚡ Performance Improvements
- Changed default model from Qwen 7B to Qwen 3B
  - Faster response times on local hardware
  - 60% smaller memory footprint (2GB vs 4.7GB)
  - 7B still available as optional upgrade

### 📦 Bundling (Work in Progress)
- Created platform bundle scripts
  - `create-bundles.sh` - Main bundling script
  - `BUNDLE_PREP.sh` - Model extraction helper
- Fixed Ollama binary download URLs
- **Known Issue**: Model file extraction blocked (investigating storage location)
- **Workaround**: Use `install.sh` for installation

### 🔧 Configuration
- Updated default config to use 3B model
- Both user and repo configs aligned
- Simplified config structure

### 🏗️ Build
- Binary version: v0.0.0-master-202602010731
- All 11 platform binaries rebuilt with fixes

---

## [0.0.1] - 2026-02-01

### 🎉 Initial Release

#### Complete Rebrand from OpenCode
- Forked from OpenCode 1.1.48
- 863 files updated with NovaHub branding
- All `opencode` → `novahub` references changed
- Package names changed: `@opencode-ai` → `@novahub`
- Fresh git repository created

#### Build System
- Installed Bun 1.3.8 runtime
- Resolved 3,568 package dependencies
- Built binaries for 11 platforms:
  - Linux: x64, arm64, x64-baseline (glibc + musl)
  - macOS: arm64, x64, x64-baseline
  - Windows: x64, x64-baseline

#### Global Command
- Fixed bin/novahub launcher script
- Created global wrapper at ~/.local/bin/novahub
- Command works from any directory
- ASCII logo updated to NovaHub

#### Local AI Integration
- Integrated Ollama as default provider
- Professional installer with Ollama bundling
- Default model: qwen2.5-coder:7b
- Config at ~/.novahub/novahub.jsonc
- No API keys required

#### Documentation
- Created 15+ documentation files:
  - DOCUMENTATION.md - Complete user guide (485 lines)
  - PROGRESS.md - Development tracker
  - OVERVIEW.md - Project summary
  - REFERENCE.md - Quick reference
  - OLLAMA_SETUP.md - AI setup guide
  - And more...

#### Provider Improvements
- Cleaned provider list (removed non-AI entries)
- Added priority ordering
- Ollama appears first as "Local AI"
- Helpful descriptions added

### Fixed
- Theme file missing (novahub.json)
- Bin launcher script (Node.js → Bun)
- ASCII logo cutoff issues
- Config validation errors

### Known Issues
- None blocking

---

## Release Strategy

- **0.0.x** - Initial development, rebranding, setup
- **0.1.x** - First working build with basic customizations  
- **0.2.x** - AI improvements and optimizations
- **0.5.x** - Feature additions
- **1.0.0** - First stable public release

---

**Maintained by:** MrNova420 | WeNova Interactive  
**Original Project:** OpenCode by Anomaly (MIT License)  
**License:** MIT
