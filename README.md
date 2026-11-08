# Labelize Printer Homebrew tap

Labelize Printer is a local virtual printer and label workspace that saves labels as PDF or PNG. This tap distributes the macOS PKG for Apple Silicon and Intel, targeting macOS 13 or later. [Project and documentation](https://github.com/GOODBOY008/labelize-printer)

## Install

```sh
brew install --cask goodboy008/labelize-printer/labelize-printer
```

If Homebrew reports an untrusted tap, review the [cask definition](Casks/labelize-printer.rb), then trust this cask and retry the installation:

```sh
brew trust --cask goodboy008/labelize-printer/labelize-printer
brew install --cask goodboy008/labelize-printer/labelize-printer
```

Open Labelize Printer from Applications to add the local printer and choose where to save files. Since v0.2.0, the Labels workspace also opens ZPL, EPL, TSPL/TSC, CPCL, and DPL files, previews every page, and saves PDF/PNG. The visual designer supports text, Code 128, QR codes, rectangles, and images, with portable `.labelize.json` templates and font import for Chinese and other scripts.

Use the title-bar language button to switch between English and Simplified Chinese. The macOS PKGs are unsigned, and app bundles use ad-hoc signatures. See the release notes for verified environments, outstanding desktop checks, and Windows/Linux installers. [Printer releases](https://github.com/GOODBOY008/labelize-printer/releases)

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
