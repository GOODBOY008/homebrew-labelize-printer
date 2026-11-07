cask "labelize-printer" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "2a44b86d987dad91ef0453a240f38e3bdd8ef369514eafd7bc9b8f8d35a6cfdc",
         intel: "70777f8b07dfc050f789825fd9b4697ebcc2b0566cf04e686d767e5d2487167a"

  url "https://github.com/GOODBOY008/labelize-printer/releases/download/v#{version}/LabelizePrinter-#{version}-macos-#{arch}-release.pkg"
  name "Labelize Printer"
  desc "Virtual printer for saving print jobs as PDF or PNG"
  homepage "https://github.com/GOODBOY008/labelize-printer"

  depends_on macos: :ventura

  pkg "LabelizePrinter-#{version}-macos-#{arch}-release.pkg"

  uninstall quit:    "com.labelize.printer",
            pkgutil: "^com\\.labelize\\.printer$"

  caveats "Open Labelize Printer after installation to set up the local print queue."
end
