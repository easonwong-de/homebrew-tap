cask "czkawka-tauri" do
  version "1.1.0"
  sha256 "47bc182cbf52bc4ddfd9db6e761bec63f7e8db6765340389c09d33336ecfadbf"

  url "https://github.com/shixinhuang99/czkawka-tauri/releases/download/#{version}/CzkawkaTauri_#{version}_universal.dmg"
  name "CzkawkaTauri"
  desc "Tauri frontend for Czkawka"
  homepage "https://github.com/shixinhuang99/czkawka-tauri"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "czkawka-tauri-ffmpeg"
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
