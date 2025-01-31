class Dar < Formula
  desc "Backup directory tree and files"
  homepage "http://dar.linux.free.fr/doc/index.html"
  url "https://downloads.sourceforge.net/project/dar/dar/2.7.2/dar-2.7.2.tar.gz"
  sha256 "973fa977c19b32b1f9ecb62153c810ba8696f644eca048f214c77ad0e8eca255"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/dar[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, big_sur:      "1fdd6b3a1928e14d8f912e37ae55e0e3c86186a5da2bc99c107f2c7b8b977c83"
    sha256 cellar: :any, catalina:     "da74fe3bf555027687c08c1070ded75381c823063d61e041573cf1b97899ce62"
    sha256 cellar: :any, mojave:       "a68d869a6b947f9a0d72afb03f11d1fae3a3401e7a4cd12737b272dae8988cb3"
  end

  depends_on "upx" => :build
  depends_on "libgcrypt"
  depends_on "lzo"
  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-build-html",
                          "--disable-dar-static",
                          "--disable-dependency-tracking",
                          "--disable-libxz-linking",
                          "--enable-mode=64"
    system "make", "install"
  end

  test do
    system bin/"dar", "-c", "test", "-R", "./Library"
    system bin/"dar", "-d", "test", "-R", "./Library"
  end
end
