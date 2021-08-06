class Trunk < Formula
  desc "Build, bundle & ship your Rust WASM application to the web"
  homepage "https://github.com/thedodd/trunk"
  url "https://github.com/thedodd/trunk/archive/v0.13.0.tar.gz"
  sha256 "69150938131330c1779e3204efa33a46e1d48767dbf76d0f805b104a4c9479e1"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/thedodd/trunk.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8010495d9acd5e7455d2128807a08d5bd8c17ac0b6b4e1b522c72d0746f73e3d"
    sha256 cellar: :any_skip_relocation, big_sur:       "6f6f785a22f0c8367b2f864b186a3cdd896b0b254d1e4fd765e1c0f5b39378c3"
    sha256 cellar: :any_skip_relocation, catalina:      "c981e1cf06e39c4eb70a17ee6bb7046517b071af8ca22b8bc998f8c876792bb8"
    sha256 cellar: :any_skip_relocation, mojave:        "3df71d613bda3ce9d2b24f4fa3511101cae904104773363917b39808b31eec14"
  end

  depends_on "rust" => :build

  uses_from_macos "openssl@1.1"
  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ConfigOpts {\n", shell_output("#{bin}/trunk config show")
  end
end
