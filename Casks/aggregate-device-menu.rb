cask "aggregate-device-menu" do
  version "1.2.0"
  sha256 "a4d90080bbd063760054c12f27ab3ac972e567ba23b193f2565e52d82b545b1d"

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
