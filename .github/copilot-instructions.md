# NovaHub Development Guidelines

NovaHub is an AI-powered development CLI tool forked from OpenCode 1.1.48. It provides a terminal interface for AI-assisted coding with local AI support via Ollama.

## Build & Development Commands

```bash
# Install dependencies
bun install

# Development
bun dev                    # Run in packages/novahub directory
bun dev <directory>        # Run against specific directory
bun dev .                  # Run in repo root

# Testing
bun test                   # Run all tests
bun test test/tool/tool.test.ts  # Run specific test file

# Type checking
bun run typecheck          # Check types across all packages

# Building
cd packages/novahub
bun run build              # Build all platform binaries
./script/build.ts --single # Build single platform only
./script/build.ts --baseline # Build baseline (non-AVX2) versions

# SDK Generation (after modifying server endpoints)
./script/generate.ts       # Regenerate @novahub/sdk from server routes
```

## Architecture Overview

### Monorepo Structure

NovaHub uses a Bun workspaces monorepo with Turbo for task orchestration:

- **`packages/novahub`**: Core CLI business logic, server, and TUI
  - `src/cli/cmd/tui/`: Terminal UI (SolidJS + OpenTUI)
  - `src/server/`: Hono-based HTTP server with OpenAPI endpoints
  - `src/session/`: AI session management and conversation state
  - `src/tool/`: AI tools (bash, edit, read, write, grep, etc.)
  - `src/provider/`: AI provider integrations (OpenAI, Anthropic, Ollama, etc.)
  - `src/agent/`: Built-in AI agents (plan, build)
  - `src/mcp/`: Model Context Protocol server integration
  - `src/lsp/`: Language Server Protocol clients
  
- **`packages/app`**: Shared SolidJS web UI components
- **`packages/desktop`**: Tauri-based desktop app (wraps packages/app)
- **`packages/plugin`**: Plugin API source for `@novahub/plugin`
- **`packages/sdk`**: Auto-generated TypeScript SDK for server API
- **`packages/util`**: Shared utilities

### Key Design Patterns

**Namespace-based organization**: Major components use TypeScript namespaces for grouping:
```typescript
export namespace Tool {
  export function define() { }
  export function execute() { }
}
export namespace Session {
  export function create() { }
  export function prompt() { }
}
```

**Zod for validation**: All inputs/outputs use Zod schemas:
```typescript
const input = z.object({
  sessionID: Identifier.schema("session"),
  content: z.string()
})
```

**Dependency injection**: Use `App.provide()` pattern for DI:
```typescript
import { App } from "./app"
const db = App.provide("database")
```

**Tool system**: AI tools implement `Tool.Info` interface with `execute()` method. Tools are registered in `src/tool/registry.ts` and exposed to AI models.

**Session-based state**: All AI conversations maintain state through `sessionID`. Sessions track messages, tools, checkpoints, and compactions.

**Provider abstraction**: AI providers (OpenAI, Anthropic, Ollama, etc.) are abstracted through Vercel AI SDK. Provider models are auto-fetched from models.dev and stored in `src/provider/models-snapshot.ts`.

## Code Style & Conventions

### General Style

- **Runtime**: Bun with TypeScript ESM modules
- **Avoid `let`**: Use `const` with ternary operators instead of if/else assignments
- **Avoid `else`**: Prefer early returns or IIFE patterns
- **Single-word naming**: Prefer `foo` over `fooBar` when possible
- **No destructuring unnecessarily**: Use `obj.a` over `const { a } = obj` to preserve context
- **Avoid `try/catch`**: Use Result patterns where possible
- **Avoid `any`**: Always type properly
- **Bun APIs preferred**: Use `Bun.file()`, `Bun.write()`, etc.
- **Type inference**: Avoid explicit annotations unless needed for exports or clarity

### Examples

**Good**:
```typescript
const foo = condition ? 1 : 2

function bar() {
  if (error) return null
  return result
}
```

**Bad**:
```typescript
let foo
if (condition) foo = 1
else foo = 2

function bar() {
  if (error) return null
  else return result
}
```

### Testing

- **No mocks**: Tests MUST use actual implementations
- **No logic duplication**: Don't duplicate business logic in tests
- **Test real behavior**: Integration tests preferred over unit tests

## Important Files & Workflows

### Mode Instructions (Critical for AI behavior)

**Location**: `packages/novahub/src/session/prompt.ts` (function `insertReminders`)

NovaHub has Plan and Build modes. Mode instruction injection was **removed in v0.2.0** to fix AI confusion with local models. Both legacy and experimental mode paths now skip injection to avoid AI response loops.

### AI Prompt System

- `src/session/prompt/`: Mode-specific prompts (plan.txt, build-switch.txt)
- `src/agent/prompt/`: Agent-specific system prompts
- `src/session/system.ts`: Base system prompt generation
- `src/session/instruction.ts`: User instructions from config

### Tool Implementation

All tools follow this pattern:
```typescript
export namespace MyTool {
  export const info = Tool.define({
    id: "my_tool",
    description: "Tool description",
    parameters: z.object({ /* ... */ }),
    execute: async (input, context) => {
      // Implementation
      return { success: true, data: result }
    }
  })
}
```

Register in `src/tool/registry.ts`.

### Server Endpoints

When adding/modifying routes in `packages/novahub/src/server/server.ts`:
1. Define route with Hono + Zod validation
2. Run `./script/generate.ts` to regenerate SDK
3. SDK types automatically available in TUI code

### Build System

The build script (`packages/novahub/script/build.ts`) creates standalone binaries for 11 platforms:
- Linux: x64, arm64, x64-baseline (glibc + musl variants)
- macOS: arm64, x64, x64-baseline  
- Windows: x64, x64-baseline

Before building, it fetches model metadata from models.dev and generates `src/provider/models-snapshot.ts`.

## NovaHub-Specific Context

### Version & Branding

- **Current version**: 0.2.0 (in development)
- **Based on**: OpenCode 1.1.48
- **Major changes from OpenCode**:
  - Rebranded to NovaHub (863 files updated)
  - AI mode instruction spam removed (v0.2.0 fix)
  - Default model changed to Qwen 3B for better local performance
  - Ollama integrated as default provider
  - All `opencode` → `novahub` references changed

### Key Features

- **Local AI**: Ollama provider for running models locally (no API keys)
- **Built-in agents**: Plan mode (readonly planning) and Build mode (execution)
- **TUI**: Rich terminal UI built with SolidJS and OpenTUI
- **MCP support**: Model Context Protocol for tool integration
- **LSP integration**: TypeScript, Python, and more language servers
- **Multi-provider**: OpenAI, Anthropic, Google, Azure, Groq, Ollama, etc.

### Configuration

- Config location: `~/.novahub/novahub.jsonc`
- Schema validation with Zod
- Supports JSONC (JSON with comments)
- Provider-specific settings (API keys, endpoints, models)

## Important Notes

- **Default branch**: `dev` (not `main`)
- **Always use parallel tools**: When multiple independent operations are needed, execute tools in parallel
- **Prefer automation**: Execute requested actions without confirmation unless blocked by missing info
- **SDK regeneration**: Required after any server route changes
- **Model snapshot**: Auto-generated, don't edit `src/provider/models-snapshot.ts` manually
