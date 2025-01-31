class Wagyu < Formula
  desc "Rust library for generating cryptocurrency wallets"
  homepage "https://github.com/AleoHQ/wagyu"
  url "https://github.com/AleoHQ/wagyu/archive/v0.6.1.tar.gz"
  sha256 "2458b3d49653acd5df5f3161205301646527eca9f6ee3d84c7871afa275bad9f"
  head "https://github.com/AleoHQ/wagyu.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "42345a553422087010c9a64ac44910b4872eda94fd1cbe4adbe8d8a3959ae0af"
    sha256 cellar: :any_skip_relocation, big_sur:       "2b818f64c4f18e5fc7694d89f1bc1d038a0095ede55e3a5ecec2c80a0a04fa1d"
    sha256 cellar: :any_skip_relocation, catalina:      "69e6539d7e3801aaea4cd14acd48684f703a4c1cac0f04790d3ada827daf77f9"
    sha256 cellar: :any_skip_relocation, mojave:        "0b6fd9b45280ecac2586b191303e0e643ef14c85cad06b6aca73e51e7af6ae46"
    sha256 cellar: :any_skip_relocation, high_sierra:   "c2175413a53a69da950ca7b879afc882f2181a34cb633e823bf2a3dc29675fc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2612ab493ca4cedcd37cfa62a329bc8ce1d0cce227a2e854aae8e3849505a6c" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/wagyu", "bitcoin"
  end
end
