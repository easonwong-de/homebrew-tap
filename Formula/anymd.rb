class Anymd < Formula
  desc "Convert any file into clean Markdown for AI agents"
  homepage "https://github.com/SylphxAI/anymd"
  version "8.5.7"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-arm64.tar.gz"
      sha256 "076b75f6389685df21a9ed0de7a2efa9799aa0ee88362372604759d71a9d4e01"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-x64.tar.gz"
      sha256 "e8b0d7002a6f2956b4cd32b749e7c0dd4249d8378b1e6cf461679dad66d52174"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-arm64-gnu.tar.gz"
      sha256 "03158666dc35d22c8576e72a07acd93074bf39d698f32c7341c18fa36ea65fd1"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-x64-gnu.tar.gz"
      sha256 "484a3328fe326a594e505ad8a08050d6ae1466a6da7d1bd557dc4bea23c517fe"
    end
  end

  def install
    bin.install "anymd"
  end

  test do
    assert_match "anymd #{version}", shell_output("#{bin}/anymd version")
  end
end
