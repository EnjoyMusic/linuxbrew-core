class Lftp < Formula
  desc "Sophisticated file transfer program"
  homepage "https://lftp.yar.ru/"
  url "https://lftp.yar.ru/ftp/lftp-4.9.2.tar.xz"
  sha256 "c517c4f4f9c39bd415d7313088a2b1e313b2d386867fe40b7692b83a20f0670d"
  license "GPL-3.0-or-later"
  revision 1

  livecheck do
    url "https://github.com/lavv17/lftp.git"
  end

  bottle do
    sha256 "68cdb9b693cf4ea5b7a8c9c0cdd02a2a2eb391c78df5e657767a59819dcbd9af" => :big_sur
    sha256 "c6e871000f9337c8fa0d56ff9b345209c13449be17e00e4e0248deeae3fd589f" => :arm64_big_sur
    sha256 "16e629365517da3f55e271f5e55c1d8ae759b5f2a2d7df669b87e93e05b948f9" => :catalina
    sha256 "7165e8f2ed29e55cc2cb819961d167fb7da7c8ebba7ababf4475c792b6f29afb" => :mojave
    sha256 "19758878a9a2296b1e96ab34b27943dbc2147c4ed9ec295ac2bc2da29878314c" => :x86_64_linux
  end

  depends_on "libidn2"
  depends_on "openssl@1.1"
  depends_on "readline"

  uses_from_macos "zlib"

  def install
    # Work around "error: no member named 'fpclassify' in the global namespace"
    if MacOS.version == :high_sierra
      ENV.delete("HOMEBREW_SDKROOT")
      ENV.delete("SDKROOT")
    end

    # Work around configure issues with Xcode 12
    # https://github.com/lavv17/lftp/issues/611
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-openssl=#{Formula["openssl@1.1"].opt_prefix}",
                          "--with-readline=#{Formula["readline"].opt_prefix}",
                          "--with-libidn2=#{Formula["libidn2"].opt_prefix}"

    system "make", "install"
  end

  test do
    system "#{bin}/lftp", "-c", "open https://ftp.gnu.org/; ls"
  end
end
