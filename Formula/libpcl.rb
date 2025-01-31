class Libpcl < Formula
  desc "C library and API for coroutines"
  homepage "http://xmailserver.org/libpcl.html"
  url "http://xmailserver.org/pcl-1.12.tar.gz"
  sha256 "e7b30546765011575d54ae6b44f9d52f138f5809221270c815d2478273319e1a"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?pcl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, big_sur:      "2ed8a2eb0ff0c53cb2a2653991386ceded74a41a8a215e0d641221092917e361"
    sha256 cellar: :any, catalina:     "11984be842d85e685f2e52d4d5155f24123a44e0f1855970c5fed1e8cb2172f5"
    sha256 cellar: :any, mojave:       "3eb3bf64576a13da02b76cf21bfd37a9889e48d3e7c0df06bd5767c61cc09d06"
    sha256 cellar: :any, high_sierra:  "2d7ce1c2a11e762dacf0e28f92a1b1f6b6a45ea4564ac579b4c0683c61ac61f7"
    sha256 cellar: :any, sierra:       "525c0925d7d3234cf5da86a892d15aa4f6d4417f302ed821e2bfd6e7cb06ef43"
    sha256 cellar: :any, el_capitan:   "1975baf018352fd1f1ca88bd39fc02db384e2f6be4017976184dda3365c60608"
    sha256 cellar: :any, yosemite:     "e9c6f7bc1efab583e44879426a5abb2ff5e7f3eb30261a81a7be723c3280c3a3"
    sha256 cellar: :any, x86_64_linux: "0f7ac6736461560ec54ab2cf752952a9e9da832e0b85cfbefbc96cb2bb9c9be5" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
