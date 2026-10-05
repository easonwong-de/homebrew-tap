class Anymd < Formula
  desc "Convert any file into clean Markdown for AI agents"
  homepage "https://github.com/SylphxAI/anymd"
  version "8.5.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-arm64.tar.gz"
      sha256 "ad9224dcb4548c4d02b076435e83d333dc70122cb6331943c59013afba94ec29"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-x64.tar.gz"
      sha256 "49b638a260ab69b76946c7bfb7d61b42c631f568b4a38dc48a9bfb8ba7259661"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-arm64-gnu.tar.gz"
      sha256 "6a499c59092858a1fca42d438de19c4d7c746b5dc2fc8358349f5d41217475b5"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-x64-gnu.tar.gz"
      sha256 "0ad9288a482a0008b9ecc892e91f80906fdda2c53b66154009158fe7a79566ea"
    end
  end

  def install
    bin.install "anymd"
  end

  test do
    assert_match "anymd #{version}", shell_output("#{bin}/anymd version")
  end
end
