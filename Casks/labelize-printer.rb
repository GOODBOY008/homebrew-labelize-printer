cask "labelize-printer" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.0"
  sha256 arm:   "2555d4e2f45bf96aed8b5bc13f72eeaf6a896e9dc23c68e412a1af8fe8888057",
         intel: "0834b964bb4aa6179223fb1706bfd8923148d473ca1e640fe64832e898e8e747"

  url "https://github.com/GOODBOY008/labelize-printer/releases/download/v#{version}/LabelizePrinter-#{version}-macos-#{arch}-release.pkg"
  name "Labelize Printer"
  desc "Label designer and virtual printer with PDF and PNG output"
  homepage "https://github.com/GOODBOY008/labelize-printer"

  depends_on macos: :ventura

  pkg "LabelizePrinter-#{version}-macos-#{arch}-release.pkg"

  uninstall quit:    "com.labelize.printer",
            pkgutil: "^com\\.labelize\\.printer$"

  caveats "Open Labelize Printer after installation to set up the local print queue."
end
