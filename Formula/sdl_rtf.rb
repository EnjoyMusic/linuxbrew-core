class SdlRtf < Formula
  desc "Sample library to display Rich Text Format (RTF) documents"
  homepage "https://www.libsdl.org/projects/SDL_rtf/"
  url "https://www.libsdl.org/projects/SDL_rtf/release/SDL_rtf-0.1.0.tar.gz"
  sha256 "3dc0274b666e28010908ced24844ca7d279e07b66f673c990d530d4ea94b757e"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "9d08d7ff2342e161defb1160668e96414902afd78756e4ab3824915385574546"
    sha256 cellar: :any, big_sur:       "d4e19ead242e52808d739cf34bd91be0b941771291437eba0c8931263fcbf9f6"
    sha256 cellar: :any, catalina:      "ee09de7e32f0992acce56ab546fb0201d7b3903a51243548b590378cccc7e6f5"
    sha256 cellar: :any, mojave:        "310bcc2756a0ba5dd9287af9159809c2519609830e07e4ef0773edfc51c8bda5"
    sha256 cellar: :any, high_sierra:   "319fe65012c94d20675b0b3dc3c9e4df59838ccca7496b81a425bded94e3c9fc"
    sha256 cellar: :any, sierra:        "c34abb198f384916d7b2a09a88c69cb84f29674031329bb7a1733e8a5ed39255"
    sha256 cellar: :any, el_capitan:    "6c7e9f7459ff062fbb48ee1a383a4fd4acc2c29f5ee9b57dea93710c94ccda11"
    sha256 cellar: :any, yosemite:      "8dd89df32c9ea02bcab36932c2f22bcb6de58d6002bd6fb9e95f9bbfe5ccf41e"
    sha256 cellar: :any, x86_64_linux:  "387e1a87657e3cd634cd172140c29804a80dc807b2c8487c0680d0d64a81749e" # linuxbrew-core
  end

  head do
    url "https://github.com/libsdl-org/SDL_rtf.git", branch: "SDL-1.2"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # SDL 1.2 is deprecated, unsupported, and not recommended for new projects.
  deprecate! date: "2013-08-17", because: :deprecated_upstream

  depends_on "sdl"

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--prefix=#{prefix}", "--disable-sdltest"
    system "make", "install"
  end
end
