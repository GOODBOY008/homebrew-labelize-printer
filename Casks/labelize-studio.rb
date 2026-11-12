cask "labelize-studio" do
  arch arm: "arm64", intel: "x86_64"

  version "0.5.0"
  sha256 arm:   "6a80566abe45c4b5b99dbb3fe99a1dae37e1782dd9bb73b2d6efcb741547fdde",
         intel: "ea8c9180981bfc80f3afd8b4eca995282afe3a53bc20465f9a109820641654c5"

  url "https://github.com/GOODBOY008/labelize-studio/releases/download/v#{version}/LabelizeStudio-#{version}-macos-#{arch}-release.pkg"
  name "Labelize Studio"
  desc "Label designer and virtual printer with PDF and PNG output"
  homepage "https://github.com/GOODBOY008/labelize-studio"

  depends_on macos: :ventura

  pkg "LabelizeStudio-#{version}-macos-#{arch}-release.pkg"

  uninstall quit:    "com.labelize.printer",
            pkgutil: "^com\\.labelize\\.printer$"

  caveats "Open Labelize Studio once after installation. Existing Labelize Printer queues and user data are retained."
end
