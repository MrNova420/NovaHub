# NovaHub Version History

# NovaHub Version History

## Version 0.2.0 (In Progress - 2026-02-01)
**Focus:** AI Response Improvements & Bundling

### Major Changes:
- **🎯 CRITICAL FIX**: Eliminated AI mode instruction spam
  - Removed 69 lines of "READ-ONLY", "MUST NOT", "STRICTLY FORBIDDEN" warnings
  - Deleted all Plan/Build mode reminders that caused AI to loop
  - Modified `packages/novahub/src/session/prompt.ts` to skip mode injections
  - AI now works naturally without constantly repeating mode rules
  
- **⚡ Performance**: Default model changed to 3B
  - Faster responses (3B vs 7B)
  - Lower memory usage (2GB vs 4.7GB)
  - 7B available as optional upgrade in config
  
- **📦 Bundling**: Work in progress
  - Created `create-bundles.sh` script
  - Created `BUNDLE_PREP.sh` for model extraction
  - Fixed Ollama binary downloads
  - **BLOCKED**: Model file location issue (see Known Issues)

### Known Issues:
- Bundling incomplete: Model files reported by Ollama at `/usr/share/ollama/.ollama/models/blobs/` but not accessible
- Bundle script needs further investigation of Ollama storage mechanism
- Temporary workaround: Use `install.sh` (fully functional)

### Binary Version:
- v0.0.0-master-202602010731

---

## Version 0.0.1 (2026-02-01)
**Base:** OpenCode 1.1.48

### Initial Release - Complete Rebranding
- Forked from OpenCode 1.1.48 (github.com/anomalyco/opencode)
- Complete rebranding to NovaHub by WeNova Interactive
- 863 files updated with new branding
- All `opencode` references changed to `novahub`
- Custom copyright headers applied
- Fresh git repository created
- Ready for customization and feature development

### Changes from OpenCode 1.1.48:
- ✅ Rebranded all packages to `@novahub/*`
- ✅ CLI command changed from `opencode` to `novahub`
- ✅ Config directory changed to `~/.novahub/`
- ✅ Updated LICENSE to WeNova Interactive
- ✅ Custom README and branding
- ✅ 40+ asset files renamed
- ✅ Theme files updated

### Status:
- 🔧 In Development
- 🎯 Goal: Maintain OpenCode functionality while customizing
- 📦 Not yet published to npm
- 🚀 Personal use - preparing for public release

### Known Issues:
- None yet - fresh fork

### Next Steps:
- Build and test all functionality
- Remove unnecessary features
- Add personal customizations
- Optimize bundle size
- Create custom themes

---

## Versioning Strategy

**Format:** `MAJOR.MINOR.PATCH`

- **0.0.x** - Initial development, rebranding, setup
- **0.1.x** - First working build with basic customizations
- **0.5.x** - Feature additions and improvements
- **1.0.0** - First stable public release

### OpenCode Version Tracking
- **Base Version:** 1.1.48 (2025-01-30)
- **Fork Date:** 2026-02-01
- **Upstream:** Can merge improvements if needed

---

**Maintained by:** MrNova420 | WeNova Interactive
**Original Project:** OpenCode by Anomaly (MIT License)
