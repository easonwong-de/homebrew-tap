cask "aggregate-device-volume" do
  version "1.0.2"
  sha256 "d5cf7c382469ac30eebe1aaa05e62a3e27b10d0eda09613c53731387ec2703d0"

  url "https://github.com/easonwong-de/Aggregate-Volume-Menu/releases/download/v#{version}/AggregateDeviceVolume.zip"
  name "AggregateDeviceVolume"
  desc "Control volume of aggregate audio devices from the menu bar"
  homepage "https://github.com/easonwong-de/Aggregate-Volume-Menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Aggregate Device Volume.app"

  zap trash: "~/Library/Preferences/de.easonwong.AggregateDeviceVolume.plist"
end
