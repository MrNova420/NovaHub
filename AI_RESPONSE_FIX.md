# Fixing AI Response Loop Issue

## Problem
AI (Qwen 2.5 Coder 7B) is stuck responding with:
- "I am in READ-ONLY mode..."
- Keeps repeating the same instructions
- Not actually responding to user queries
- Taking 40-120 seconds per response

## Likely Causes

1. **System Prompt Too Restrictive** - Plan mode instructions are confusing the model
2. **Model Quality** - 7B model struggling with complex instructions
3. **Context Issues** - System messages building up and confusing model
4. **Ollama Connection** - API might be having issues

## Quick Fixes

### Fix 1: Switch to Build Mode
```bash
# In NovaHub, press Shift+Tab or use /
# Switch from Plan mode → Build mode
# Build mode gives file edit permissions
```

### Fix 2: Test Ollama Directly
```bash
# Test if Ollama itself works
ollama run qwen2.5-coder:7b "Write a Python hello world"

# If this works, problem is in NovaHub's prompts
# If this fails, problem is with Ollama/model
```

### Fix 3: Clear Session and Restart
```bash
# In NovaHub:
/new              # Start fresh session
# Or
Ctrl+C            # Exit NovaHub
novahub           # Restart
```

### Fix 4: Try Different Model
```bash
# Download smaller, faster model
ollama pull phi3:mini

# In NovaHub config (~/.novahub/novahub.jsonc):
# Change: "model": "ollama/phi3:mini"

# Restart novahub
```

## Permanent Solution

The issue is likely the system prompt for plan mode is too complex for the model.

### Option 1: Simplify Instructions

Edit `~/.novahub/novahub.jsonc`:

```jsonc
{
  "instructions": [
    "You are NovaHub AI",
    "Help write code and answer questions",
    "Be concise"
  ]
}
```

### Option 2: Use Build Mode by Default

NovaHub has two modes:
- **Plan Mode** (Tab): Read-only, for planning
- **Build Mode** (Shift+Tab): Can edit files, execute code

For coding tasks, use Build mode.

### Option 3: Update Model Config

Some models need specific settings:

```jsonc
{
  "provider": {
    "ollama": {
      "models": {
        "qwen2.5-coder:7b": {
          "options": {
            "temperature": 0.7,
            "num_predict": 2048,
            "stop": ["User:", "Assistant:"],
            "repeat_penalty": 1.1
          }
        }
      }
    }
  }
}
```

## Testing

1. **Test Ollama directly:**
   ```bash
   curl http://localhost:11434/api/generate -d '{
     "model": "qwen2.5-coder:7b",
     "prompt": "Write a Python function that adds two numbers",
     "stream": false
   }'
   ```

2. **Check NovaHub logs:**
   ```bash
   # Look for errors
   ~/.novahub/logs/
   ```

3. **Try simple query in Build mode:**
   - Start NovaHub
   - Press Shift+Tab (or use menu to switch to Build)
   - Ask: "write a hello world in python"
   - Should work better

## Best Solution for Now

**Use Build Mode for actual coding:**
1. Start `novahub`
2. Switch to Build mode (not Plan)
3. Give it simple, direct instructions
4. Model should respond properly

**Plan mode** might be too complex for local models. Build mode should work fine!

---

For v0.2.0, we'll bundle a smaller 3B model that works better with complex instructions, and make 7B an optional download for users who want more power.
