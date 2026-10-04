cask "aggregate-volume-menu" do
  version "1.0.0"
  sha256 "bed8c3b51473970a99513b87d27a60108a1ffe70cae7c3c924565a4bfd82f036"

  url "https://github.com/easonwong-de/Aggregate-Volume-Menu/releases/download/v#{version}/AggregateVolumeMenu.zip"
  name "AggregateVolumeMenu"
  desc "Control volume of aggregate audio devices from the menu bar"
  homepage "https://github.com/easonwong-de/Aggregate-Volume-Menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Aggregate Device Volume.app"

  zap trash: [
    "~/Library/Preferences/de.easonwong.AggregateVolumeMenu.plist",
  ]
end
