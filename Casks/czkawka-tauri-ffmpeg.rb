cask "czkawka-tauri-ffmpeg" do
  version "1.1.0"
  sha256 "92478c96b83753214d0f3fdfe8bbce0157e18af0bf97337aeba1bb9a65e2b27c"

  url "https://github.com/shixinhuang99/czkawka-tauri/releases/download/#{version}/CzkawkaTauri_#{version}_universal_ffmpeg.dmg"
  name "CzkawkaTauri (FFmpeg)"
  desc "Tauri frontend for Czkawka with bundled FFmpeg"
  homepage "https://github.com/shixinhuang99/czkawka-tauri"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "czkawka-tauri"
  depends_on macos: :monterey

  app "CzkawkaTauri.app"

  zap trash: [
    "~/Library/Application Support/com.shixinhuang.czkawka-tauri",
    "~/Library/Caches/com.shixinhuang.czkawka-tauri",
    "~/Library/Preferences/com.shixinhuang.czkawka-tauri.plist",
    "~/Library/Saved Application State/com.shixinhuang.czkawka-tauri.savedState",
    "~/Library/WebKit/com.shixinhuang.czkawka-tauri",
  ]
end
