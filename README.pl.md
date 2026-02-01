<p align="center">
  <a href="https://novahub.ai">
    <picture>
      <source srcset="packages/console/app/src/asset/logo-ornate-dark.svg" media="(prefers-color-scheme: dark)">
      <source srcset="packages/console/app/src/asset/logo-ornate-light.svg" media="(prefers-color-scheme: light)">
      <img src="packages/console/app/src/asset/logo-ornate-light.svg" alt="NovaHub logo">
    </picture>
  </a>
</p>
<p align="center">Otwartoźródłowy agent kodujący AI.</p>
<p align="center">
  <a href="https://novahub.ai/discord"><img alt="Discord" src="https://img.shields.io/discord/1391832426048651334?style=flat-square&label=discord" /></a>
  <a href="https://www.npmjs.com/package/novahub"><img alt="npm" src="https://img.shields.io/npm/v/novahub?style=flat-square" /></a>
  <a href="https://github.com/anomalyco/novahub/actions/workflows/publish.yml"><img alt="Build status" src="https://img.shields.io/github/actions/workflow/status/anomalyco/novahub/publish.yml?style=flat-square&branch=dev" /></a>
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
  <a href="README.br.md">Português (Brasil)</a>
</p>

[![NovaHub Terminal UI](packages/web/src/assets/lander/screenshot.png)](https://novahub.ai)

---

### Instalacja

```bash
# YOLO
curl -fsSL https://novahub.ai/install | bash

# Menedżery pakietów
npm i -g novahub@latest        # albo bun/pnpm/yarn
scoop install novahub             # Windows
choco install novahub             # Windows
brew install anomalyco/tap/novahub # macOS i Linux (polecane, zawsze aktualne)
brew install novahub              # macOS i Linux (oficjalna formuła brew, rzadziej aktualizowana)
paru -S novahub-bin               # Arch Linux
mise use -g novahub               # dowolny system
nix run nixpkgs#novahub           # lub github:anomalyco/novahub dla najnowszej gałęzi dev
```

> [!TIP]
> Przed instalacją usuń wersje starsze niż 0.1.x.

### Aplikacja desktopowa (BETA)

NovaHub jest także dostępny jako aplikacja desktopowa. Pobierz ją bezpośrednio ze strony [releases](https://github.com/anomalyco/novahub/releases) lub z [novahub.ai/download](https://novahub.ai/download).

| Platforma             | Pobieranie                            |
| --------------------- | ------------------------------------- |
| macOS (Apple Silicon) | `novahub-desktop-darwin-aarch64.dmg` |
| macOS (Intel)         | `novahub-desktop-darwin-x64.dmg`     |
| Windows               | `novahub-desktop-windows-x64.exe`    |
| Linux                 | `.deb`, `.rpm` lub AppImage           |

```bash
# macOS (Homebrew)
brew install --cask novahub-desktop
# Windows (Scoop)
scoop bucket add extras; scoop install extras/novahub-desktop
```

#### Katalog instalacji

Skrypt instalacyjny stosuje następujący priorytet wyboru ścieżki instalacji:

1. `$NOVAHUB_INSTALL_DIR` - Własny katalog instalacji
2. `$XDG_BIN_DIR` - Ścieżka zgodna ze specyfikacją XDG Base Directory
3. `$HOME/bin` - Standardowy katalog binarny użytkownika (jeśli istnieje lub można go utworzyć)
4. `$HOME/.novahub/bin` - Domyślny fallback

```bash
# Przykłady
NOVAHUB_INSTALL_DIR=/usr/local/bin curl -fsSL https://novahub.ai/install | bash
XDG_BIN_DIR=$HOME/.local/bin curl -fsSL https://novahub.ai/install | bash
```

### Agents

NovaHub zawiera dwóch wbudowanych agentów, między którymi możesz przełączać się klawiszem `Tab`.

- **build** - Domyślny agent z pełnym dostępem do pracy developerskiej
- **plan** - Agent tylko do odczytu do analizy i eksploracji kodu
  - Domyślnie odmawia edycji plików
  - Pyta o zgodę przed uruchomieniem komend bash
  - Idealny do poznawania nieznanych baz kodu lub planowania zmian

Dodatkowo jest subagent **general** do złożonych wyszukiwań i wieloetapowych zadań.
Jest używany wewnętrznie i można go wywołać w wiadomościach przez `@general`.

Dowiedz się więcej o [agents](https://novahub.ai/docs/agents).

### Dokumentacja

Więcej informacji o konfiguracji NovaHub znajdziesz w [**dokumentacji**](https://novahub.ai/docs).

### Współtworzenie

Jeśli chcesz współtworzyć NovaHub, przeczytaj [contributing docs](./CONTRIBUTING.md) przed wysłaniem pull requesta.

### Budowanie na NovaHub

Jeśli pracujesz nad projektem związanym z NovaHub i używasz "novahub" jako części nazwy (na przykład "novahub-dashboard" lub "novahub-mobile"), dodaj proszę notatkę do swojego README, aby wyjaśnić, że projekt nie jest tworzony przez zespół NovaHub i nie jest z nami w żaden sposób powiązany.

### FAQ

#### Czym to się różni od Claude Code?

Jest bardzo podobne do Claude Code pod względem możliwości. Oto kluczowe różnice:

- 100% open source
- Niezależne od dostawcy. Chociaż polecamy modele oferowane przez [NovaHub Zen](https://novahub.ai/zen); NovaHub może być używany z Claude, OpenAI, Google, a nawet z modelami lokalnymi. W miarę jak modele ewoluują, różnice będą się zmniejszać, a ceny spadać, więc ważna jest niezależność od dostawcy.
- Wbudowane wsparcie LSP
- Skupienie na TUI. NovaHub jest budowany przez użytkowników neovim i twórców [terminal.shop](https://terminal.shop); przesuwamy granice tego, co jest możliwe w terminalu.
- Architektura klient/serwer. Pozwala np. uruchomić NovaHub na twoim komputerze, a sterować nim zdalnie z aplikacji mobilnej. To znaczy, że frontend TUI jest tylko jednym z możliwych klientów.

---

**Dołącz do naszej społeczności** [Discord](https://discord.gg/novahub) | [X.com](https://x.com/novahub)
