# Labelize Studio Homebrew tap

[Labelize Studio](https://github.com/GOODBOY008/labelize-studio), formerly Labelize Printer, is a desktop label designer, printer-language viewer, and local virtual printer. This tap distributes the macOS PKG for Apple Silicon and Intel, targeting macOS 13 or later.

## Install

```sh
brew install --cask goodboy008/labelize-studio/labelize-studio
```

If Homebrew reports an untrusted tap, review the [cask definition](Casks/labelize-studio.rb), then trust this cask and retry:

```sh
brew trust --cask goodboy008/labelize-studio/labelize-studio
brew install --cask goodboy008/labelize-studio/labelize-studio
```

Open **Labelize Studio** from Applications. Use the multi-tab workspace to open ZPL, EPL, TSPL/TSC, CPCL, and DPL files, or create a label with the visual designer's 15 object types. Preview pages and save PDF/PNG, with automatic local drafts and session recovery. Use **Settings → System printer** to add the optional **Labelize Printer** print queue.

The app supports English and Simplified Chinese. The PKGs are unsigned and the app bundles use ad-hoc signatures. See [Studio releases](https://github.com/GOODBOY008/labelize-studio/releases) for validation, known limitations, Windows/Linux installers, and SHA256SUMS.

## Upgrade from Labelize Printer

Let accepted jobs finish, quit the old desktop, and stop its background service:

```sh
"/Applications/Labelize Printer.app/Contents/MacOS/labelize-printer-daemon" stop
brew tap goodboy008/labelize-studio
brew update
brew upgrade --cask goodboy008/labelize-studio/labelize-studio
```

Open **Labelize Studio** once afterward to refresh the existing login-service path. The `cask_renames.json` entry migrates the old cask token. The GitHub repository redirect keeps existing tap clones usable. The printer queue, settings, job history, and workspace drafts keep their original identities; no data deletion or queue reinstallation is required. See the [migration guide](https://github.com/GOODBOY008/labelize-studio/blob/main/MIGRATION.md).

## Later upgrades and uninstall

Studio's **Settings → Software update** recognizes both old and new Homebrew records, saves the workspace, and offers a command to copy after safely stopping printing. It never runs Homebrew automatically. For a manual upgrade, quit the app and run:

```sh
"/Applications/Labelize Studio.app/Contents/MacOS/labelize-printer-daemon" stop
brew update
brew upgrade --cask goodboy008/labelize-studio/labelize-studio
```

To uninstall, remove the system printer in the app, quit, and run the same `stop` command. Then:

```sh
brew uninstall --cask goodboy008/labelize-studio/labelize-studio
```

Saved output and user data are retained. The cask continues using the original macOS package receipt and bundle ID so upgrades replace the existing installation.

## Release sync

The [sync workflow](https://github.com/GOODBOY008/homebrew-labelize-studio/actions/workflows/sync-cask.yml) checks stable Studio releases hourly and on demand. Both macOS asset digests must match the verified `SHA256SUMS` before the cask changes. Drafts and prereleases are ignored; changed installers require a new version.
