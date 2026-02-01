# NovaHub Bundling Strategy v2 - Hybrid Approach

## Goal
- Bundle small model (2-3GB) for instant use
- Provide easy download for larger 7B model in-app
- Best of both worlds: fast install + powerful option

---

## Bundle Composition

### What Gets Bundled (Automatic Install)
```
novahub-v0.2.0-linux-x64-bundle.tar.gz (~2.3GB)
├── bin/
│   ├── novahub          # NovaHub CLI
│   └── ollama           # Ollama runtime
├── models/
│   └── qwen2.5-coder-3b.gguf (2GB) # Bundled model
└── config/
    └── novahub.jsonc    # Pre-configured
```

**Bundled Model:** Qwen2.5-Coder 3B (2GB)
- Fast install
- Good quality for most tasks
- Works on 8GB RAM
- 32K context

### Optional Download (In-App)
**Available in NovaHub UI:**

```
┌─ Model Management ──────────────────────────────────┐
│                                                      │
│  Current Model: qwen2.5-coder:3b (2GB) ✓ Active    │
│                                                      │
│  Recommended Upgrades:                              │
│  ⬇ Qwen2.5-Coder 7B (4.7GB) ⭐ RECOMMENDED          │
│     Better quality • 32K context • ~5min download    │
│     [Download Now]                                   │
│                                                      │
│  Other Models:                                       │
│  ⬇ DeepSeek-Coder V2 16B (9GB)                      │
│     Most powerful • 16K context • ~10min download    │
│     [Download]                                       │
│                                                      │
│  ⬇ Phi3 Mini (2.3GB)                                │
│     Lightweight • Fast • 4K context                  │
│     [Download]                                       │
│                                                      │
│  ⬇ CodeLlama 13B (7.4GB)                            │
│     Meta's model • 16K context                       │
│     [Download]                                       │
│                                                      │
└──────────────────────────────────────────────────────┘
```

---

## User Experience

### First Install (v0.2.0):
```bash
$ curl install.sh | bash
Downloading NovaHub bundle (2.3GB)... ████████████ 100%
Extracting...
Installing...
✓ NovaHub v0.2.0 installed!
✓ Local AI ready: Qwen 3B

$ novahub
# Works immediately with 3B model!
```

### Upgrade to 7B (In-App):
```bash
$ novahub
# In TUI, press /models
# Select "Download Qwen 7B"
Downloading qwen2.5-coder:7b (4.7GB)... ████████████ 100%
✓ Model downloaded!
✓ Switched to qwen2.5-coder:7b

# Now using more powerful model
```

---

## Implementation

### Phase 1: Bundle 3B Model
```bash
# Create bundle with 3B model
mkdir -p bundle/bin bundle/models bundle/config

# Get Qwen 3B
ollama pull qwen2.5-coder:3b
cp ~/.ollama/models/.../qwen-3b.gguf bundle/models/

# Package
tar -czf novahub-linux-x64-bundle.tar.gz bundle/
```

### Phase 2: Add Model Downloader in NovaHub

Create new command: `/download-model`

```typescript
// packages/novahub/src/cli/cmd/tui/component/dialog-model-download.tsx

export function DialogModelDownload() {
  const [downloading, setDownloading] = useState(false)
  const [progress, setProgress] = useState(0)
  
  const downloadModel = async (modelId: string) => {
    setDownloading(true)
    
    // Call Ollama API to pull model
    const response = await fetch('http://localhost:11434/api/pull', {
      method: 'POST',
      body: JSON.stringify({ name: modelId, stream: true })
    })
    
    // Stream progress updates
    const reader = response.body.getReader()
    // Update progress bar as download happens
    
    setDownloading(false)
    toast.show({ message: `${modelId} ready to use!`, variant: 'success' })
  }
  
  return (
    <box>
      <text>Download Qwen2.5-Coder 7B?</text>
      <text>Size: 4.7GB • Time: ~5 minutes</text>
      
      {downloading ? (
        <ProgressBar progress={progress} />
      ) : (
        <button onClick={() => downloadModel('qwen2.5-coder:7b')}>
          Download Now
        </button>
      )}
    </box>
  )
}
```

### Phase 3: Auto-switch After Download

```typescript
// After download completes
await sdk.client.config.set({
  model: 'ollama/qwen2.5-coder:7b'
})

// Reload NovaHub with new model
await sdk.client.instance.dispose()
await sync.bootstrap()
```

---

## Bundle Sizes

### Per Platform:

```
With 3B Model (Bundled):
NovaHub binary:        40MB
Ollama binary:         50MB
Qwen 3B model:         2GB
Config/docs:           5MB
────────────────────────────
Total:                 ~2.1GB
Compressed (tar.gz):   ~1.8GB
```

### Optional Downloads (User Choice):

```
Qwen 7B:               4.7GB
DeepSeek 16B:          9GB
CodeLlama 13B:         7.4GB
Phi3 Mini:             2.3GB
```

---

## Configuration Update

Default config ships with 3B, lists 7B as recommended:

```jsonc
{
  "model": "ollama/qwen2.5-coder:3b",
  
  "provider": {
    "ollama": {
      "models": {
        "qwen2.5-coder:3b": {
          "name": "Qwen 2.5 Coder 3B (Bundled)",
          "limit": { "context": 32768, "output": 8192 },
          "bundled": true
        },
        "qwen2.5-coder:7b": {
          "name": "Qwen 2.5 Coder 7B ⭐ Recommended",
          "limit": { "context": 32768, "output": 8192 },
          "downloadSize": "4.7GB",
          "downloadTime": "~5 minutes",
          "recommended": true
        },
        "deepseek-coder-v2:16b": {
          "name": "DeepSeek Coder V2 16B",
          "limit": { "context": 16384, "output": 4096 },
          "downloadSize": "9GB"
        }
      }
    }
  }
}
```

---

## Benefits

✅ **Fast Install** - Only 1.8GB download  
✅ **Works Immediately** - 3B model bundled  
✅ **Easy Upgrade** - Download 7B from within NovaHub  
✅ **User Choice** - Pick model based on hardware  
✅ **Bandwidth Friendly** - Don't force 4.7GB on everyone  

---

## Implementation Timeline

### Week 1:
- [ ] Test Qwen 3B quality (vs 7B)
- [ ] Create bundle with 3B model
- [ ] Test bundle on clean system

### Week 2:
- [ ] Add model downloader UI (`/download-model`)
- [ ] Progress bar for downloads
- [ ] Auto-switch after download
- [ ] Update config with model list

### Week 3:
- [ ] Test full flow: Install → Use 3B → Download 7B
- [ ] Polish UI
- [ ] Documentation

### Week 4:
- [ ] Release v0.2.0
- [ ] Upload bundles to GitHub Releases

---

## Summary

**Bundle:** Qwen 3B (2GB) - Fast install, works great  
**Easy Download:** Qwen 7B (4.7GB) - Better quality, one button  
**Result:** Best of both worlds! 🎉

Users get:
1. Fast 2GB install with working AI
2. Easy upgrade to 7B if they want more power
3. Choice based on their hardware/needs

Perfect! 🚀
