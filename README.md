# Labelize Printer Homebrew tap

Labelize Printer is a local virtual printer that saves print jobs as PDF or PNG. This tap distributes the macOS PKG for Apple Silicon and Intel. The package requires macOS 13 or later. [Labelize Printer](https://github.com/GOODBOY008/labelize-printer) · [简体中文](https://github.com/GOODBOY008/labelize-printer/blob/main/README.zh-CN.md)

## Install

```sh
brew install --cask goodboy008/labelize-printer/labelize-printer
```

Open Labelize Printer from Applications to add the local printer and choose where to save files. The v0.1.1 preview PKG is unsigned. See the release notes for validation details and the Windows and Linux installers. [Printer releases](https://github.com/GOODBOY008/labelize-printer/releases)

## Upgrade and uninstall

For an upgrade, let pending jobs finish, quit Labelize Printer, and stop its background process.

```sh
"/Applications/Labelize Printer.app/Contents/MacOS/labelize-printer-daemon" stop
brew update
brew upgrade --cask goodboy008/labelize-printer/labelize-printer
```

To uninstall, remove the printer in the app, quit the app, and run the same `stop` command. Homebrew then removes the app and installer receipt. Saved files remain in your output folder.

```sh
brew uninstall --cask goodboy008/labelize-printer/labelize-printer
```

## Release sync

The sync workflow checks Printer releases hourly and can also run on demand. It selects the newest published `vX.Y.Z` release, including previews, and updates the cask after both macOS installer digests match `SHA256SUMS`. A changed installer needs a new version. [Sync workflow](https://github.com/GOODBOY008/homebrew-labelize-printer/actions/workflows/sync-cask.yml)
