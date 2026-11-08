cask "labelize-printer" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "ac220a60022cfa097192a5cbdb25b7af6f4fa17ab07a026b2e11b3137250e6d9",
         intel: "e61e5db3f03d4a7fad9dbe2cd706248b28d1c494514030875efb9efbbb661a0b"

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
