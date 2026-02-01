function truthy(key: string) {
  const value = process.env[key]?.toLowerCase()
  return value === "true" || value === "1"
}

export namespace Flag {
  export const NOVAHUB_AUTO_SHARE = truthy("NOVAHUB_AUTO_SHARE")
  export const NOVAHUB_GIT_BASH_PATH = process.env["NOVAHUB_GIT_BASH_PATH"]
  export const NOVAHUB_CONFIG = process.env["NOVAHUB_CONFIG"]
  export declare const NOVAHUB_CONFIG_DIR: string | undefined
  export const NOVAHUB_CONFIG_CONTENT = process.env["NOVAHUB_CONFIG_CONTENT"]
  export const NOVAHUB_DISABLE_AUTOUPDATE = truthy("NOVAHUB_DISABLE_AUTOUPDATE")
  export const NOVAHUB_DISABLE_PRUNE = truthy("NOVAHUB_DISABLE_PRUNE")
  export const NOVAHUB_DISABLE_TERMINAL_TITLE = truthy("NOVAHUB_DISABLE_TERMINAL_TITLE")
  export const NOVAHUB_PERMISSION = process.env["NOVAHUB_PERMISSION"]
  export const NOVAHUB_DISABLE_DEFAULT_PLUGINS = truthy("NOVAHUB_DISABLE_DEFAULT_PLUGINS")
  export const NOVAHUB_DISABLE_LSP_DOWNLOAD = truthy("NOVAHUB_DISABLE_LSP_DOWNLOAD")
  export const NOVAHUB_ENABLE_EXPERIMENTAL_MODELS = truthy("NOVAHUB_ENABLE_EXPERIMENTAL_MODELS")
  export const NOVAHUB_DISABLE_AUTOCOMPACT = truthy("NOVAHUB_DISABLE_AUTOCOMPACT")
  export const NOVAHUB_DISABLE_MODELS_FETCH = truthy("NOVAHUB_DISABLE_MODELS_FETCH")
  export const NOVAHUB_DISABLE_CLAUDE_CODE = truthy("NOVAHUB_DISABLE_CLAUDE_CODE")
  export const NOVAHUB_DISABLE_CLAUDE_CODE_PROMPT =
    NOVAHUB_DISABLE_CLAUDE_CODE || truthy("NOVAHUB_DISABLE_CLAUDE_CODE_PROMPT")
  export const NOVAHUB_DISABLE_CLAUDE_CODE_SKILLS =
    NOVAHUB_DISABLE_CLAUDE_CODE || truthy("NOVAHUB_DISABLE_CLAUDE_CODE_SKILLS")
  export declare const NOVAHUB_DISABLE_PROJECT_CONFIG: boolean
  export const NOVAHUB_FAKE_VCS = process.env["NOVAHUB_FAKE_VCS"]
  export declare const NOVAHUB_CLIENT: string
  export const NOVAHUB_SERVER_PASSWORD = process.env["NOVAHUB_SERVER_PASSWORD"]
  export const NOVAHUB_SERVER_USERNAME = process.env["NOVAHUB_SERVER_USERNAME"]

  // Experimental
  export const NOVAHUB_EXPERIMENTAL = truthy("NOVAHUB_EXPERIMENTAL")
  export const NOVAHUB_EXPERIMENTAL_FILEWATCHER = truthy("NOVAHUB_EXPERIMENTAL_FILEWATCHER")
  export const NOVAHUB_EXPERIMENTAL_DISABLE_FILEWATCHER = truthy("NOVAHUB_EXPERIMENTAL_DISABLE_FILEWATCHER")
  export const NOVAHUB_EXPERIMENTAL_ICON_DISCOVERY =
    NOVAHUB_EXPERIMENTAL || truthy("NOVAHUB_EXPERIMENTAL_ICON_DISCOVERY")
  export const NOVAHUB_EXPERIMENTAL_DISABLE_COPY_ON_SELECT = truthy("NOVAHUB_EXPERIMENTAL_DISABLE_COPY_ON_SELECT")
  export const NOVAHUB_ENABLE_EXA =
    truthy("NOVAHUB_ENABLE_EXA") || NOVAHUB_EXPERIMENTAL || truthy("NOVAHUB_EXPERIMENTAL_EXA")
  export const NOVAHUB_EXPERIMENTAL_BASH_DEFAULT_TIMEOUT_MS = number("NOVAHUB_EXPERIMENTAL_BASH_DEFAULT_TIMEOUT_MS")
  export const NOVAHUB_EXPERIMENTAL_OUTPUT_TOKEN_MAX = number("NOVAHUB_EXPERIMENTAL_OUTPUT_TOKEN_MAX")
  export const NOVAHUB_EXPERIMENTAL_OXFMT = NOVAHUB_EXPERIMENTAL || truthy("NOVAHUB_EXPERIMENTAL_OXFMT")
  export const NOVAHUB_EXPERIMENTAL_LSP_TY = truthy("NOVAHUB_EXPERIMENTAL_LSP_TY")
  export const NOVAHUB_EXPERIMENTAL_LSP_TOOL = NOVAHUB_EXPERIMENTAL || truthy("NOVAHUB_EXPERIMENTAL_LSP_TOOL")
  export const NOVAHUB_DISABLE_FILETIME_CHECK = truthy("NOVAHUB_DISABLE_FILETIME_CHECK")
  export const NOVAHUB_EXPERIMENTAL_PLAN_MODE = NOVAHUB_EXPERIMENTAL || truthy("NOVAHUB_EXPERIMENTAL_PLAN_MODE")
  export const NOVAHUB_EXPERIMENTAL_MARKDOWN = truthy("NOVAHUB_EXPERIMENTAL_MARKDOWN")
  export const NOVAHUB_MODELS_URL = process.env["NOVAHUB_MODELS_URL"]
  export const NOVAHUB_MODELS_PATH = process.env["NOVAHUB_MODELS_PATH"]

  function number(key: string) {
    const value = process.env[key]
    if (!value) return undefined
    const parsed = Number(value)
    return Number.isInteger(parsed) && parsed > 0 ? parsed : undefined
  }
}

// Dynamic getter for NOVAHUB_DISABLE_PROJECT_CONFIG
// This must be evaluated at access time, not module load time,
// because external tooling may set this env var at runtime
Object.defineProperty(Flag, "NOVAHUB_DISABLE_PROJECT_CONFIG", {
  get() {
    return truthy("NOVAHUB_DISABLE_PROJECT_CONFIG")
  },
  enumerable: true,
  configurable: false,
})

// Dynamic getter for NOVAHUB_CONFIG_DIR
// This must be evaluated at access time, not module load time,
// because external tooling may set this env var at runtime
Object.defineProperty(Flag, "NOVAHUB_CONFIG_DIR", {
  get() {
    return process.env["NOVAHUB_CONFIG_DIR"]
  },
  enumerable: true,
  configurable: false,
})

// Dynamic getter for NOVAHUB_CLIENT
// This must be evaluated at access time, not module load time,
// because some commands override the client at runtime
Object.defineProperty(Flag, "NOVAHUB_CLIENT", {
  get() {
    return process.env["NOVAHUB_CLIENT"] ?? "cli"
  },
  enumerable: true,
  configurable: false,
})
