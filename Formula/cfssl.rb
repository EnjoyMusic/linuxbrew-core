class Cfssl < Formula
  desc "CloudFlare's PKI toolkit"
  homepage "https://cfssl.org/"
  url "https://github.com/cloudflare/cfssl/archive/v1.6.1.tar.gz"
  sha256 "00f5316e8f065a48eeb02b7359aa67699a5c1362b09c6e8faa19d8f35451c1d8"
  license "BSD-2-Clause"
  head "https://github.com/cloudflare/cfssl.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4299d4da1a34a95d8e236b78a45a64e0dd93a500f71263473840738012aa7995"
    sha256 cellar: :any_skip_relocation, big_sur:       "7d7e9bdd3cfa8ea3f7ae66942cbdc6569b2266a0fe915ce4daaf2b7cca4a3adb"
    sha256 cellar: :any_skip_relocation, catalina:      "a08499a7f125f108ce9f3c6104056683da2dfbd106c6c1c6057cb824082d296a"
    sha256 cellar: :any_skip_relocation, mojave:        "5d5340fd4e30e7361c57445bf7149a5358aa32a763c0c9319303d93234d47b77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf7f763e97d6c7e50ecf3d7ccab262c75d3ebe7bf793354f55ccad688e7f5d5e" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "libtool"

  def install
    ldflags = "-s -w -X github.com/cloudflare/cfssl/cli/version.version=#{version}"

    system "go", "build", *std_go_args(ldflags: ldflags), "-o", "#{bin}/cfssl", "cmd/cfssl/cfssl.go"
    system "go", "build", *std_go_args(ldflags: ldflags), "-o", "#{bin}/cfssljson", "cmd/cfssljson/cfssljson.go"
    system "go", "build", "-o", "#{bin}/cfsslmkbundle", "cmd/mkbundle/mkbundle.go"
  end

  def caveats
    <<~EOS
      `mkbundle` has been installed as `cfsslmkbundle` to avoid conflict
      with Mono and other tools that ship the same executable.
    EOS
  end

  test do
    (testpath/"request.json").write <<~EOS
      {
        "CN" : "Your Certificate Authority",
        "hosts" : [],
        "key" : {
          "algo" : "rsa",
          "size" : 4096
        },
        "names" : [
          {
            "C" : "US",
            "ST" : "Your State",
            "L" : "Your City",
            "O" : "Your Organization",
            "OU" : "Your Certificate Authority"
          }
        ]
      }
    EOS
    shell_output("#{bin}/cfssl genkey -initca request.json > response.json")
    response = JSON.parse(File.read(testpath/"response.json"))
    assert_match(/^-----BEGIN CERTIFICATE-----.*/, response["cert"])
    assert_match(/.*-----END CERTIFICATE-----$/, response["cert"])
    assert_match(/^-----BEGIN RSA PRIVATE KEY-----.*/, response["key"])
    assert_match(/.*-----END RSA PRIVATE KEY-----$/, response["key"])

    assert_match(/^Version:\s+#{version}/, shell_output("#{bin}/cfssl version"))
  end
end
