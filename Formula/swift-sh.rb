class SwiftSh < Formula
  desc "Scripting with easy zero-conf dependency imports"
  homepage "https://github.com/mxcl/swift-sh"
  url "https://github.com/mxcl/swift-sh/archive/2.3.1.tar.gz"
  sha256 "8f82caa9f15b5fdb832d5434ff8ef1278636e3bf37ee49a10b82017a136bbc91"
  license "Unlicense"
  head "https://github.com/mxcl/swift-sh.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ae96f2af5b6b0faf1df4a6aed6623106720a4b91ebadc43c0e66baae1df14669"
    sha256 cellar: :any_skip_relocation, big_sur:       "5db4172c5bca85aac1f31f1e83968df989e0db8afedf92b1bdbcab5544c72966"
    sha256 cellar: :any_skip_relocation, catalina:      "3d3c1325d0c06dac4286c6ef9e2c97beb0e1cd264b6efc1c739297ca2c46a521"
    sha256 cellar: :any_skip_relocation, mojave:        "a095e50c1706b5cd0305c201891262b384ee8f3dfdc03bbfd98c715cacdc9845"
  end

  depends_on xcode: ["11.0", :build]

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/swift-sh"
    bin.install ".build/release/swift-sh-edit" if OS.mac?
  end

  test do
    (testpath/"test.swift").write "#!/usr/bin/env swift sh"
    system "#{bin}/swift-sh", "eject", "test.swift"
    assert_predicate testpath/"Test"/"Package.swift", :exist?
  end
end
