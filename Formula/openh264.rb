class Openh264 < Formula
  desc "H.264 codec from Cisco"
  homepage "https://www.openh264.org/"
  url "https://github.com/cisco/openh264/archive/v2.1.1.tar.gz"
  sha256 "af173e90fce65f80722fa894e1af0d6b07572292e76de7b65273df4c0a8be678"
  license "BSD-2-Clause"
  revision 1
  head "https://github.com/cisco/openh264.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "c63f32513ab056a1848184f11c0d82b1c233d81be4a9dd9f29df89029be9ea75"
    sha256 cellar: :any,                 big_sur:       "b1679e30909ec05ca67b2f134a8e322319f845530005c185bb7284c2b2fd1301"
    sha256 cellar: :any,                 catalina:      "0c16ce9eb6bc29bddf43376bc6ceff0ab6843572edb3fb631dfc9e135d7a3208"
    sha256 cellar: :any,                 mojave:        "f42bf16f4d86c24a6562530db55ffb5957a83b26443735bc902f5856b3470cba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "647e0adf2ebb12ca8f9b10db09e8f8b2eebd2e99284eee9268ab84c291fcaf34" # linuxbrew-core
  end

  depends_on "nasm" => :build

  def install
    system "make", "install-shared", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <wels/codec_api.h>
      int main() {
        ISVCDecoder *dec;
        WelsCreateDecoder (&dec);
        WelsDestroyDecoder (dec);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lopenh264", "-o", "test"
    system "./test"
  end
end
