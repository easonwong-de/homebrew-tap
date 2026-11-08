class Anymd < Formula
  desc "Convert any file into clean Markdown for AI agents"
  homepage "https://github.com/SylphxAI/anymd"
  version "8.5.11"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-arm64.tar.gz"
      sha256 "b032bf8ec3759d795daafa8c86ad38eafb1c14ad79d2abb911212a895ceb71da"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-x64.tar.gz"
      sha256 "6cd2f3c8ccbaa2ab69022198b4b8111d7f53b6456fc348b0a86cfee461e9c764"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-arm64-gnu.tar.gz"
      sha256 "e46164585e6fd3cef6bf1d1e9b041e8b98e83cfe09ca82b837a02fb1c91166ca"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-x64-gnu.tar.gz"
      sha256 "05b5466899e233ace66961ae39e263b21141b9766caf6a83bd1190dedbbe8b68"
    end
  end

  def install
    bin.install "anymd"
  end

  test do
    assert_match "anymd #{version}", shell_output("#{bin}/anymd version")
  end
end
