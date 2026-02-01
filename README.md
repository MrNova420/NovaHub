<p align="center">
  <h1 align="center">🌟 NovaHub</h1>
</p>
<p align="center"><strong>Your Central Development Hub</strong></p>
<p align="center">A comprehensive development platform with AI-powered coding assistance</p>
<p align="center">
  <em>Created by <a href="https://github.com/MrNova420">MrNova420</a> | WeNova Interactive</em>
</p>
<p align="center">
  <a href="https://github.com/MrNova420/NovaHub"><img alt="GitHub" src="https://img.shields.io/badge/GitHub-NovaHub-blue?style=flat-square" /></a>
  <img alt="Status" src="https://img.shields.io/badge/status-in%20development-yellow?style=flat-square" />
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green?style=flat-square" />
</p>

---

<p align="center">
  <strong>Based on <a href="https://github.com/anomalyco/opencode">OpenCode</a> - Fully rebranded and customized</strong>
</p>

<p align="center">
  <a href="README.md">English</a> |
  <a href="README.zh.md">简体中文</a> |
  <a href="README.zht.md">繁體中文</a> |
  <a href="README.ko.md">한국어</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.es.md">Español</a> |
  <a href="README.fr.md">Français</a> |
  <a href="README.it.md">Italiano</a> |
  <a href="README.da.md">Dansk</a> |
  <a href="README.ja.md">日本語</a> |
  <a href="README.pl.md">Polski</a> |
  <a href="README.ru.md">Русский</a> |
  <a href="README.ar.md">العربية</a> |
  <a href="README.no.md">Norsk</a> |
  <a href="README.br.md">Português (Brasil)</a> |
  <a href="README.th.md">ไทย</a>
</p>

[![NovaHub Terminal UI](packages/web/src/assets/lander/screenshot.png)](https://novahub.ai)

---

### Installation

```bash
# YOLO
curl -fsSL https://novahub.ai/install | bash

# Package managers
npm i -g novahub@latest        # or bun/pnpm/yarn
scoop install novahub             # Windows
choco install novahub             # Windows
brew install anomalyco/tap/novahub # macOS and Linux (recommended, always up to date)
brew install novahub              # macOS and Linux (official brew formula, updated less)
paru -S novahub-bin               # Arch Linux
mise use -g novahub               # Any OS
nix run nixpkgs#novahub           # or github:anomalyco/novahub for latest dev branch
```

> [!TIP]
> Remove versions older than 0.1.x before installing.

### Desktop App (BETA)

NovaHub is also available as a desktop application. Download directly from the [releases page](https://github.com/anomalyco/novahub/releases) or [novahub.ai/download](https://novahub.ai/download).

| Platform              | Download                              |
| --------------------- | ------------------------------------- |
| macOS (Apple Silicon) | `novahub-desktop-darwin-aarch64.dmg` |
| macOS (Intel)         | `novahub-desktop-darwin-x64.dmg`     |
| Windows               | `novahub-desktop-windows-x64.exe`    |
| Linux                 | `.deb`, `.rpm`, or AppImage           |

```bash
# macOS (Homebrew)
brew install --cask novahub-desktop
# Windows (Scoop)
scoop bucket add extras; scoop install extras/novahub-desktop
```

#### Installation Directory

The install script respects the following priority order for the installation path:

1. `$NOVAHUB_INSTALL_DIR` - Custom installation directory
2. `$XDG_BIN_DIR` - XDG Base Directory Specification compliant path
3. `$HOME/bin` - Standard user binary directory (if exists or can be created)
4. `$HOME/.novahub/bin` - Default fallback

```bash
# Examples
NOVAHUB_INSTALL_DIR=/usr/local/bin curl -fsSL https://novahub.ai/install | bash
XDG_BIN_DIR=$HOME/.local/bin curl -fsSL https://novahub.ai/install | bash
```

### Agents

NovaHub includes two built-in agents you can switch between with the `Tab` key.

- **build** - Default, full access agent for development work
- **plan** - Read-only agent for analysis and code exploration
  - Denies file edits by default
  - Asks permission before running bash commands
  - Ideal for exploring unfamiliar codebases or planning changes

Also, included is a **general** subagent for complex searches and multistep tasks.
This is used internally and can be invoked using `@general` in messages.

Learn more about [agents](https://novahub.ai/docs/agents).

### Documentation

For more info on how to configure NovaHub [**head over to our docs**](https://novahub.ai/docs).

### Contributing

If you're interested in contributing to NovaHub, please read our [contributing docs](./CONTRIBUTING.md) before submitting a pull request.

### Building on NovaHub

If you are working on a project that's related to NovaHub and is using "novahub" as a part of its name; for example, "novahub-dashboard" or "novahub-mobile", please add a note to your README to clarify that it is not built by the NovaHub team and is not affiliated with us in any way.

### FAQ

#### How is this different from Claude Code?

It's very similar to Claude Code in terms of capability. Here are the key differences:

- 100% open source
- Not coupled to any provider. Although we recommend the models we provide through [NovaHub Zen](https://novahub.ai/zen); NovaHub can be used with Claude, OpenAI, Google or even local models. As models evolve the gaps between them will close and pricing will drop so being provider-agnostic is important.
- Out of the box LSP support
- A focus on TUI. NovaHub is built by neovim users and the creators of [terminal.shop](https://terminal.shop); we are going to push the limits of what's possible in the terminal.
- A client/server architecture. This for example can allow NovaHub to run on your computer, while you can drive it remotely from a mobile app. Meaning that the TUI frontend is just one of the possible clients.

---

**Join our community** [Discord](https://discord.gg/novahub) | [X.com](https://x.com/novahub)
