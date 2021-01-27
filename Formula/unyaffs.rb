class Unyaffs < Formula
  desc "Extract files from a YAFFS2 filesystem image"
  homepage "https://git.b-ehlers.de/ehlers/unyaffs/"
  url "https://git.b-ehlers.de/ehlers/unyaffs/archive/0.9.7.tar.gz"
  sha256 "792d18c3866910e25026aaa9dcfdec4b67bca7453ce5b2474d1ce8e9d31b2c69"
  license "GPL-2.0-only"
  head "https://git.b-ehlers.de/ehlers/unyaffs.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 3
    sha256 "54982f10cb8c866e7370886765744c109f3566717f7af6f397e8a83a7ca65520" => :big_sur
    sha256 "d5516a71d691f78f1efb0d7f12f2a8ab2b4500ad2a9c1e1ccd5ace316111a1a1" => :arm64_big_sur
    sha256 "0319fb2b8ee918808e30a0bb5deef42abaf7d4afe35cff538b4ed513f06de16e" => :catalina
    sha256 "1c3b921af84a9fee0bb8faf7d420ff2a3d6e6a4e42aeec235d8587a8ccd5da61" => :mojave
    sha256 "87fe812b32d400d209db224005c40e7dd5f0c43d6147f4800b415a19f128a1ea" => :x86_64_linux
  end

  def install
    system "make"
    bin.install "unyaffs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unyaffs -V")
  end
end
