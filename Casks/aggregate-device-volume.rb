cask "aggregate-device-volume" do
  version "1.3.0"
  sha256 "6413b02cdff38c5c51454592b5aec4c014514cafcd5d895e99929d0cd4bc9065"

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
