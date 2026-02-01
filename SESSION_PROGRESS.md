# NovaHub Session Progress - February 1, 2026

## Session Summary: AI Response System Overhaul

### Problem Statement
Local AI models (Qwen 2.5 Coder 3B) were outputting JSON-formatted fake tool calls instead of natural text responses.

Example of broken behavior:
```
User: hello
AI: {name: greet, arguments: {message: "Hello!"}}
```

Expected behavior:
```
User: hello
AI: Hello!
```

---

## Solutions Implemented

### 1. Created `respond` Tool
**File:** `packages/novahub/src/tool/respond.ts`

A real tool that accepts text and displays it to users. This works WITH Qwen's function-calling behavior.

```typescript
export const RespondTool = Tool.define("respond", {
  description: "Use this to respond with plain text for greetings...",
  parameters: z.object({
    message: z.string()
  }),
  async execute(params) {
    return { title: "", output: params.message, metadata: {} }
  }
})
```

### 2. Auto-Repair Fake Tool Calls
**File:** `packages/novahub/src/session/llm.ts` (lines 189-228)

When Qwen calls fake tools like "greet", "greeting", "hello", we automatically convert them to "respond":

```typescript
const greetingTools = ["greet", "greeting", "greetings", "hello", "respond_text", "reply", "answer"]
if (greetingTools.includes(lower)) {
  // Extract message and redirect to respond tool
  return { ...failed.toolCall, toolName: "respond", input: JSON.stringify({ message }) }
}
```

### 3. UI Renderer for Respond Tool
**File:** `packages/novahub/src/cli/cmd/tui/routes/session/index.tsx`

Added custom renderer that displays only the message (no JSON, no tool name):

```typescript
function RespondTool(props: ToolProps<any>) {
  return (
    <Show when={props.output}>
      <box paddingLeft={3} marginTop={1}>
        <text>{props.output}</text>
      </box>
    </Show>
  )
}
```

### 4. JSON Text Filter (Fallback)
**File:** `packages/novahub/src/cli/cmd/tui/routes/session/index.tsx`

If Qwen outputs literal JSON text instead of calling a tool, detect and extract the message:

```typescript
const multilineMatch = text.match(/\{\s*name\s*:\s*(\w+)\s*,\s*arguments\s*:\s*\{[^}]*message\s*:\s*([^}\n]+)/i)
if (multilineMatch && ['greet', 'greeting', ...].includes(multilineMatch[1].toLowerCase())) {
  return multilineMatch[2].trim() // Just the message
}
```

### 5. Default Agent Config
**File:** `.novahub/novahub.jsonc`

Added config option to set Plan mode as default:

```json
{
  "model": "ollama/qwen2.5-coder:3b",
  "default_agent": "plan"
}
```

### 6. Simplified Local AI Prompt
**File:** `packages/novahub/src/session/prompt/local-ai.txt`

Streamlined instructions that work WITH Qwen's behavior:
- Focus on `respond` tool as primary communication method
- Removed confusing restrictions
- Clear examples

---

## Current Status

### ✅ What Works
- Respond tool is created and registered
- Auto-repair system catches fake tool names
- UI renderer displays messages cleanly
- Config supports default agent selection
- Regex pattern correctly matches Qwen's JSON format

### ❌ Known Issues
**Primary Issue:** Qwen 3B still outputs JSON text format

Possible causes:
1. Text filter not executing (needs debugging)
2. JSON appearing in different part type than expected
3. Qwen 3B fundamentally incompatible with tool-based approach
4. Streaming causing partial matches to fail

**Secondary Issue:** Plan mode not defaulting consistently
- Config added but needs session restart to take effect
- Object.values order not guaranteed in JavaScript

---

## Commits Made (12 total)

1. `9d490d6` - Fix: AI now responds with text, not fake tool calls
2. `fe72ba5` - Fix AI tool calling: clarify text vs tool usage
3. `3fe9083` - Set Plan mode as default & strengthen instructions
4. `a701bd7` - Add 'respond' tool to fix Qwen text responses
5. `eb84744` - Simplify local-ai prompt
6. `2e03b83` - Add auto-repair for fake greeting tools
7. `7bb43a0` - Add UI renderer for respond tool - CRITICAL FIX
8. `7a94e99` - Add JSON text filter for literal JSON responses
9. `2d3ac0f` - Fix regex to match Qwen's exact multiline JSON format
10. `29caaff` - Add default_agent config and debug logging

**Ready to push:** 12 commits ahead of origin/master

---

## Next Steps

### Immediate Debugging
1. Run `novahub --print-logs` to see filter execution
2. Check if console.log shows "Detected JSON greeting"
3. Determine where JSON is appearing (text part vs tool part)

### Alternative Solutions
1. **Try different model:** llama3.1:8b or qwen2.5:7b (non-coder)
   - Better instruction following
   - Less aggressive function calling
   
2. **SDK-level interception:** Catch JSON before part creation
   - Intercept in llm.ts before streamText
   - Parse tool calls from text manually

3. **Hybrid approach:** Detect model type and use different strategies
   - Qwen Coder → aggressive filtering
   - Other models → normal flow

### Testing
- [ ] Fresh installation test
- [ ] Verify installer works
- [ ] Test onboarding flow
- [ ] Confirm 3B model is default

---

## Files Modified This Session

### Core Changes
- `packages/novahub/src/tool/respond.ts` (NEW)
- `packages/novahub/src/tool/registry.ts` (import + register)
- `packages/novahub/src/session/llm.ts` (auto-repair logic)
- `packages/novahub/src/cli/cmd/tui/routes/session/index.tsx` (renderer + filter)
- `packages/novahub/src/session/prompt/local-ai.txt` (simplified)
- `packages/novahub/src/agent/agent.ts` (reordered: plan first)

### Config
- `.novahub/novahub.jsonc` (added default_agent)
- `~/.novahub/novahub.jsonc` (updated from template)

### Documentation
- `SESSION_PROGRESS.md` (this file)
- `plan.md` (updated with current status)

---

## Architecture Notes

### Three-Layer Defense
1. **Prompt Layer:** Tell AI to use respond tool
2. **Repair Layer:** Convert fake tools → respond
3. **Filter Layer:** Parse JSON text → extract message

### Why This Approach
Qwen 2.5 Coder is trained for function calling and can't easily switch to pure text mode. Instead of fighting it, we:
- Accept that it will call tools
- Provide a legitimate tool to call
- Catch mistakes and fix them
- Parse literal JSON as last resort

### Learnings
- Can't force local models to follow prompts perfectly
- Tool repair is powerful (experimental_repairToolCall)
- UI rendering matters as much as tool execution
- JavaScript object order isn't guaranteed (Object.values)
- Regex needs to match EXACT format (whitespace matters)

---

## Version Info
- **Current:** v0.0.0-master-202602012220
- **Started session at:** v0.0.0-master-202602012119
- **12 builds** during this session
- **12 commits** ready to push

---

## Recommendation

**Short term:** Debug with --print-logs to understand why filter isn't working

**Medium term:** Test with llama3.1:8b (known good instruction following)

**Long term:** Consider model-specific prompt strategies in system.ts

**For release:** Document that Qwen 3B Coder has limitations, recommend 7B+ models for best experience
