class Rbspy < Formula
  desc "Sampling profiler for Ruby"
  homepage "https://rbspy.github.io/"
  url "https://github.com/rbspy/rbspy/archive/v0.8.1.tar.gz"
  sha256 "ddbec968d632dc9bac7b0b71cdcf8a7316d1ba7d081e3b981f48f6d740b80301"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dbed950fa25c0ff29944a5a61471c25cad5efee82b6105897575777fea7fb3a1"
    sha256 cellar: :any_skip_relocation, big_sur:       "569bb211d59c916dee39ef09682bcac9f018bb6798f10df1b0b4c7adca0e2eb0"
    sha256 cellar: :any_skip_relocation, catalina:      "29d02e56c40eabe356016d1fc1ac5540d5ec9424050f304ca36af1a407ee276a"
    sha256 cellar: :any_skip_relocation, mojave:        "5a58cc5bbd4b797bd7fc1708ad7dc6ebdcd046bffce7b14c16f3d0f21fee71d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "accfbb3564439b80cd09a339fe3fca011c3dd9336480c8649e8cdd416860d1e9" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    recording = <<~EOS
      H4sICDJNbmAAA3JlcG9ydAC9ks1OwzAQhO88RbUnkKzGqfPTRIi34FRV1to11MKxLdtphaq8O
      w5QVEEPnHrd2ZlPu5ogon+nq7sTRBy8UTxgUtCXlBIIs8YPKkTtLPRAl9WSAYGYMCSe9JAXs0
      /JyKO2UnHlndxnc1O2bcfWrCJg0bpfct2UrOsopdOUsSmgzDmbU16dAyEapfxiIxcvo5Upk7c
      ZGZTBpA+Ke0w5Au5H+2bd0T5kDUV0ZkxnzY7GEDDaKuugpxP5SUbEK1Hfd/vgXgMOyyD+RkLx
      HPMXChHUsfj8SnHNdWayC6YQ4ibM9oIppbwJsywvoI8Davt0Gy6btgS83uWzq1XTEkj7oHDH5
      0lVreuqrlmTC/yPitZXK1rSlrbNV0U/ACePNHUiAwAA
    EOS

    (testpath/"recording.gz").write Base64.decode64(recording.delete("\n"))
    system bin/"rbspy", "report", "-f", "summary", "-i", "recording.gz",
                        "-o", "result"

    expected_result = <<~EOS
      % self  % total  name
      100.00   100.00  sleep [c function] - (unknown)
        0.00   100.00  ccc - sample_program.rb
        0.00   100.00  bbb - sample_program.rb
        0.00   100.00  aaa - sample_program.rb
        0.00   100.00  <main> - sample_program.rb
    EOS
    assert_equal File.read("result"), expected_result
  end
end
