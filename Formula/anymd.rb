class Anymd < Formula
  desc "Convert any file into clean Markdown for AI agents"
  homepage "https://github.com/SylphxAI/anymd"
  version "8.5.14"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-arm64.tar.gz"
      sha256 "8bbdc1184dbf372dba304e499dd1e5ad480df47a41cb3d075580adc02aafac4f"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-darwin-x64.tar.gz"
      sha256 "424eb909c529f100d09a995116f8491d173d03185c2225aaf22fdd4b4e8d938f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-arm64-gnu.tar.gz"
      sha256 "4d1cca0f004f2a3a1b62219a3adeb689eeb0743373dcf250a82a02ab264bb60f"
    end
    on_intel do
      url "https://github.com/SylphxAI/anymd/releases/download/v#{version}/anymd-linux-x64-gnu.tar.gz"
      sha256 "54ed44e354f5ade69ff15cc9048fca85981701132079801222bc82b3f8ec06d6"
    end
  end

  def install
    bin.install "anymd"
  end

  test do
    assert_match "anymd #{version}", shell_output("#{bin}/anymd version")
  end
end
