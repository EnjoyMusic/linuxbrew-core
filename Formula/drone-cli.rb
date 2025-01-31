class DroneCli < Formula
  desc "Command-line client for the Drone continuous integration server"
  homepage "https://drone.io"
  url "https://github.com/drone/drone-cli.git",
      tag:      "v1.4.0",
      revision: "43e52be34cbf216fece99d8754b5ef96527566be"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2506e576a09c124cfe6f6a5eb6906c49b04ce0090b3e05db980df3adb6d06c1c"
    sha256 cellar: :any_skip_relocation, big_sur:       "7a76db340f0fe6269331b081004d40d152dddf8027514cbbbc6c075909bc0669"
    sha256 cellar: :any_skip_relocation, catalina:      "7e5bfff2d039507cf02fd17ba86b3abd254b531eae177ff40ef4bb998e7e9473"
    sha256 cellar: :any_skip_relocation, mojave:        "e0545bddd3c764979c708a80e6904c7f1ac5d0e8634da25f70f623098c6c0104"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62a92781c865e68278cf222ebaa114a777634ddd29fb8dde0b8a599a891bdb5b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", "-trimpath", "-o",
           bin/"drone", "drone/main.go"
    prefix.install_metafiles
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/drone --version")

    assert_match "manage logs", shell_output("#{bin}/drone log 2>&1")
  end
end
