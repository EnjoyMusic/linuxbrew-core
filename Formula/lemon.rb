class Lemon < Formula
  desc "LALR(1) parser generator like yacc or bison"
  homepage "https://www.hwaci.com/sw/lemon/"
  url "https://www.sqlite.org/2021/sqlite-src-3360000.zip"
  version "3.36.0"
  sha256 "25a3b9d08066b3a9003f06a96b2a8d1348994c29cc912535401154501d875324"
  license "blessing"

  livecheck do
    formula "sqlite"
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c9895753eefde9fd60263be373f014f1cb77bbd4065ff1c2c6fca12450bbc138"
    sha256 cellar: :any_skip_relocation, big_sur:       "e6b34bdbe078fb14319d9ece2baf5e8525755681b0746533614beae982c60c47"
    sha256 cellar: :any_skip_relocation, catalina:      "33b24b43065b09972b1920ef895cea10367a24c62d868fec55fefc77b87cf5c9"
    sha256 cellar: :any_skip_relocation, mojave:        "02cb0c5dfe67351858960a11708173a226d62e4085635a692b41525607ab1454"
  end

  def install
    pkgshare.install "tool/lempar.c"

    # patch the parser generator to look for the 'lempar.c' template file where we've installed it
    inreplace "tool/lemon.c", "lempar.c", "#{pkgshare}/lempar.c"

    system ENV.cc, "-o", "lemon", "tool/lemon.c"
    bin.install "lemon"

    pkgshare.install "test/lemon-test01.y"
    doc.install "doc/lemon.html"
  end

  test do
    system "#{bin}/lemon", "-d#{testpath}", "#{pkgshare}/lemon-test01.y"
    system ENV.cc, "lemon-test01.c"
    assert_match "tests pass", shell_output("./a.out")
  end
end
