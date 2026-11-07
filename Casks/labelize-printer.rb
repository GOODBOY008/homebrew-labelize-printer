cask "labelize-printer" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "8e4277713f61da63e283c076f4481763b4dd561b7fff157342dc39a0b3231652",
         intel: "01277d9c8086e7bd81c188dfe56ac2c611cbc73c87b364489b1b51dba0e64690"

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
