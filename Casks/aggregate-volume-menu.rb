cask "aggregate-volume-menu" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/easonwong-de/Aggregate-Volume-Menu/releases/download/v#{version}/AggregateVolumeMenu.zip"
  name "AggregateVolumeMenu"
  desc "Control volume of aggregate audio devices from the menu bar"
  homepage "https://github.com/easonwong-de/Aggregate-Volume-Menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "AggregateVolumeMenu.app"

  zap trash: [
    "~/Library/Preferences/de.easonwong.AggregateVolumeMenu.plist",
  ]
end
