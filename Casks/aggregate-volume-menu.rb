cask "aggregate-volume-menu" do
  version "1.0.1"
  sha256 "538684249cf0f55eb75bb71cde05672601aa5f47aef79284291114494572503e"

  url "https://github.com/easonwong-de/Aggregate-Volume-Menu/releases/download/v#{version}/AggregateVolumeMenu.zip"
  name "AggregateVolumeMenu"
  desc "Control volume of aggregate audio devices from the menu bar"
  homepage "https://github.com/easonwong-de/Aggregate-Volume-Menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Aggregate Device Volume.app"

  zap trash: [
    "~/Library/Preferences/de.easonwong.AggregateVolumeMenu.plist",
  ]
end
