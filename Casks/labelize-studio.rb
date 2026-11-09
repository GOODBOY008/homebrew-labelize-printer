cask "labelize-studio" do
  arch arm: "arm64", intel: "x86_64"

  version "0.4.0"
  sha256 arm:   "7b323c46e17737f0a165e414d0bb2a1f8f06bd74ae89be875e24438fce566ab3",
         intel: "4e99db651385222b0cfa01adc92fea99e9c10740a61b7afa85de0ec59334924f"

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
