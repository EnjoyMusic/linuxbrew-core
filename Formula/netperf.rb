class Netperf < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://hewlettpackard.github.io/netperf/"
  url "https://github.com/HewlettPackard/netperf/archive/netperf-2.7.0.tar.gz"
  sha256 "4569bafa4cca3d548eb96a486755af40bd9ceb6ab7c6abd81cc6aa4875007c4e"
  head "https://github.com/HewlettPackard/netperf.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fb2e8ee85592d6dff9445af33d752ea5e73abb92fe690a7844e556059ba9e9f9"
    sha256 cellar: :any_skip_relocation, big_sur:       "de1b7e8643383ecc20cdd23742d2d7518dcb8bf49b77c98f32abed7dbca70f73"
    sha256 cellar: :any_skip_relocation, catalina:      "da28e83fa25e8284ee5acc7fa327d886bb53ab20035cd07703909b7556ab25e1"
    sha256 cellar: :any_skip_relocation, mojave:        "cdd840b5e300383245d703973fcd238d58b4bd89d2ae3ba6769db297b2ddb1f9"
    sha256 cellar: :any_skip_relocation, high_sierra:   "cf086e0d276a572aba8318f7080cedc94b36a7b612cdbb4bcc3ceefef0080c53"
    sha256 cellar: :any_skip_relocation, sierra:        "4d3f648081c84ad697d608b56bcfce3237de7c34c4e4a53d9851628f9d50cd5d"
    sha256 cellar: :any_skip_relocation, el_capitan:    "c6e96625b1f83a7f83d3c9b53b8584ab65d73cfd59bc38672588ba82d37ecc1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1d056b27016b8262bf9960a1d466f536222dba7369e954d1be8fae1a53de83c" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end
end
