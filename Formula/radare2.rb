class Radare2 < Formula
  desc "Reverse engineering framework"
  homepage "https://radare.org"
  url "https://github.com/radareorg/radare2/archive/5.4.2.tar.gz"
  sha256 "d3c337e893d7d1e7d5af8b527af3d4469c92898f0249f1b6263ea3325c9455b9"
  license "LGPL-3.0-only"
  head "https://github.com/radareorg/radare2.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 arm64_big_sur: "941c71f1c57c135e73f02d8150d72ea57f0735338dc6182e37f3bbc0c679e4ae"
    sha256 big_sur:       "ab92b305f1612a6cf496e2834d49373961cf6c13afc8ca9fec38a35b3d8d2d27"
    sha256 catalina:      "134ffba76d80a57059ca795247baf5eabdf5199b48755d3416826f08832dca3d"
    sha256 mojave:        "687edf30826363d8870960bec6916375afe57fcfaf9a1fb4e10cdacb0bca1e90"
    sha256 x86_64_linux:  "bc60f4f6b78bd57a9299cb0e8afedcf18d841cf142f96a13cac40067cc3ab340" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "radare2 #{version}", shell_output("#{bin}/r2 -v")
  end
end
