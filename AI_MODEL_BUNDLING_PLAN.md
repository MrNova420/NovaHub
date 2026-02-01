# NovaHub - AI Model Bundling Plan

**Goal:** Bundle a small, high-quality AI model (2-6GB) with NovaHub for instant out-of-box usage

**Status:** Planning Phase  
**Target Version:** 0.2.0

---

## Why Bundle a Model?

✅ **Zero Setup** - Works immediately after install  
✅ **No Internet Required** - Fully offline after install  
✅ **Privacy First** - Code never leaves your machine  
✅ **No API Keys** - Completely free to use  
✅ **Fast** - No network latency  

---

## Model Selection Criteria

### Requirements:
- **Size:** 2-6GB maximum (fits on most systems)
- **Quality:** Good code generation and understanding
- **Speed:** Fast inference on CPU (< 3 seconds per response)
- **License:** Open source, commercial use allowed
- **Format:** GGUF or compatible with Ollama

### Hardware Targets:
- **Minimum:** 8GB RAM, any CPU
- **Recommended:** 16GB RAM, modern CPU
- **Optimal:** 16GB+ RAM, GPU support

---

## Model Candidates (2-6GB Range)

### 🥇 Top Candidates

#### 1. Qwen2.5-Coder 3B (2GB)
- **Size:** ~2GB GGUF
- **Strengths:** Excellent code quality, 32K context, fast
- **Performance:** Great for coding tasks
- **License:** Apache 2.0
- **Status:** ⭐ **RECOMMENDED**

#### 2. Phi-3 Mini (2.3GB)
- **Size:** 2.3GB
- **Strengths:** Microsoft, very fast, good quality
- **Performance:** Good for general coding
- **License:** MIT
- **Status:** Strong candidate

#### 3. Deepseek-Coder 1.3B (800MB)
- **Size:** 800MB
- **Strengths:** Ultra lightweight, surprisingly good
- **Performance:** Fast, decent quality
- **License:** Apache 2.0
- **Status:** Backup option (very small)

#### 4. StarCoder2 3B (1.7GB)
- **Size:** 1.7GB
- **Strengths:** Hugging Face, great for code completion
- **Performance:** Fast, specialized for code
- **License:** Apache 2.0
- **Status:** Good alternative

#### 5. TinyLlama 1.1B (637MB)
- **Size:** 637MB
- **Strengths:** Extremely small, still functional
- **Performance:** Basic tasks, very fast
- **License:** Apache 2.0
- **Status:** Emergency backup

---

## Testing Plan

### Phase 1: Download & Test (Week 1)
```bash
# Test each candidate
ollama pull qwen2.5-coder:3b
ollama pull phi3:mini
ollama pull deepseek-coder:1.3b
ollama pull starcoder2:3b
ollama pull tinyllama
```

### Phase 2: Benchmark (Week 1-2)

**Test Cases:**
- Code generation (write a function)
- Code explanation (explain existing code)
- Bug fixing (find and fix bugs)
- Refactoring (improve code structure)
- Documentation (write docs)

**Metrics:**
- Response quality (1-10)
- Response speed (seconds)
- Context understanding
- Code correctness
- RAM usage
- CPU usage

### Phase 3: User Testing (Week 2)
- Real-world coding tasks
- Multiple programming languages
- Different complexity levels
- Edge cases

---

## Integration Plan

### Step 1: Model Selection
- [ ] Test all 5 candidates
- [ ] Benchmark performance
- [ ] Select winner (likely Qwen2.5-Coder 3B)

### Step 2: Packaging
- [ ] Download GGUF model file
- [ ] Optimize quantization (Q4_K_M recommended)
- [ ] Package with NovaHub installer
- [ ] Test extraction and loading

### Step 3: Installer Update
```bash
# Updated install.sh
- Download NovaHub
- Install Ollama
- Extract bundled model to ~/.ollama/models/
- Verify model works
- Set as default in config
```

### Step 4: UI Integration
- [ ] Show bundled model in provider list with "📦 Bundled"
- [ ] Display model size (e.g., "2GB - Bundled with NovaHub")
- [ ] Show hardware requirements
- [ ] Add model info dialog

### Step 5: Model Management
- [ ] Detect if bundled model exists
- [ ] Allow switching to downloaded models
- [ ] Show disk space usage
- [ ] Add "Download more models" button

---

## Custom Fine-Tuning (Future)

### Phase 1: Data Collection
- [ ] Gather NovaHub-specific coding patterns
- [ ] Collect user interactions (opt-in)
- [ ] Create training dataset
- [ ] Validate data quality

### Phase 2: Fine-Tuning
- [ ] Select base model (Qwen2.5-Coder 3B)
- [ ] Set up training pipeline (LoRA)
- [ ] Train for NovaHub workflows
- [ ] Test and validate improvements

### Phase 3: NovaHub Model v1
- [ ] Name: "NovaHub Coder 3B"
- [ ] Optimized for: CLI workflows, terminal context
- [ ] Special features: NovaHub command understanding
- [ ] Release as official NovaHub model

---

## Provider List with Model Sizes

### Proposed UI:

```
┌─ Select Provider ────────────────────────────────────────┐
│                                                           │
│  Local AI (No API Key)                                   │
│  ◉ Ollama - Local AI                                     │
│    └─ Browse Models...                                   │
│                                                           │
│  Bundled Models                                          │
│  📦 NovaHub Coder 3B (2GB) - Bundled ⭐                   │
│     Recommended • Fast • No download needed              │
│                                                           │
│  Downloaded Models                                       │
│  ✓ qwen2.5-coder:7b (4.7GB)                              │
│     32K context • Great for coding                       │
│  ✓ deepseek-coder-v2:16b (9GB)                           │
│     16K context • Most powerful                          │
│                                                           │
│  Available to Download                                   │
│  ⬇ codellama:13b (7.4GB)                                 │
│     Meta's coding model                                  │
│  ⬇ phi3:mini (2.3GB)                                     │
│     Microsoft • Lightweight                              │
│                                                           │
│  Cloud Providers                                         │
│  ○ Anthropic - Claude models (API key required)         │
│  ○ OpenAI - ChatGPT models (API key required)           │
│  ○ Google - Gemini models (API key required)            │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

### Model Info Display:
```
┌─ Model Details: qwen2.5-coder:7b ────────────────────────┐
│                                                           │
│  Size: 4.7GB                                             │
│  RAM Required: 8GB minimum, 16GB recommended             │
│  Context Window: 32,768 tokens                           │
│  Speed: ~2s per response (CPU)                           │
│  Cost: Free (local)                                      │
│                                                           │
│  Capabilities:                                           │
│  ✓ Code generation                                       │
│  ✓ Code explanation                                      │
│  ✓ Bug fixing                                            │
│  ✓ Refactoring                                           │
│  ✓ Multiple languages                                    │
│                                                           │
│  [Download] [Set as Default] [Remove]                    │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

---

## Implementation Phases

### 🔵 Phase 1: Ollama Integration (In Progress)
- [x] Install Ollama in installer
- [x] Configure Ollama provider
- [x] Add to provider list
- [ ] Test with models

### 🟡 Phase 2: Model Selection (Week 1-2)
- [ ] Download all candidates
- [ ] Run benchmarks
- [ ] Select best model
- [ ] Document decision

### 🟠 Phase 3: Bundling (Week 2-3)
- [ ] Package model with installer
- [ ] Auto-extract on install
- [ ] Verify it works
- [ ] Test on clean system

### 🔴 Phase 4: UI Enhancement (Week 3-4)
- [ ] Show model sizes
- [ ] Display requirements
- [ ] Add download progress
- [ ] Model management UI

### 🟣 Phase 5: Fine-Tuning (Month 2)
- [ ] Collect training data
- [ ] Fine-tune base model
- [ ] Test NovaHub model
- [ ] Release v1

---

## Disk Space Management

### Default Installation:
```
NovaHub: ~200MB
Ollama: ~50MB
Bundled Model (Qwen 3B): ~2GB
─────────────────────────
Total: ~2.3GB
```

### With Additional Models:
```
+ qwen2.5-coder:7b: 4.7GB
+ deepseek-v2:16b: 9GB
+ codellama:13b: 7.4GB
─────────────────────────
Total: ~23.4GB (if all downloaded)
```

### Recommendations:
- **8GB RAM:** Bundled 3B model only (2.3GB total)
- **16GB RAM:** Add 7B model (7GB total)
- **32GB+ RAM:** Download multiple models (up to 25GB)

---

## Success Metrics

### For v0.2.0:
- [ ] Model bundled with installer
- [ ] Works offline immediately after install
- [ ] < 5 second response time on average CPU
- [ ] Accurate code generation (75%+ correctness)
- [ ] Runs on 8GB RAM systems

### For v1.0.0:
- [ ] Custom fine-tuned NovaHub model
- [ ] Advanced model management UI
- [ ] Multiple bundled models (small/medium/large)
- [ ] GPU acceleration support
- [ ] Model switching without restart

---

## Timeline

**Week 1:** Model selection and benchmarking  
**Week 2:** Integration and packaging  
**Week 3:** UI enhancements and testing  
**Week 4:** Release v0.2.0 with bundled model  
**Month 2:** Custom fine-tuning  
**Month 3:** Advanced features and v1.0.0

---

## Notes

- Start with Qwen2.5-Coder 3B (best size/quality ratio)
- Can always add more models later
- Users can still use cloud providers if they want
- Focus on ease of use and zero setup

---

**Status:** 📋 Planning  
**Next Step:** Download and test model candidates  
**Target:** v0.2.0 release with bundled AI model
