class Fetchx < Formula
  desc "FreeBSD fetch utility (portable CLI downloader)"
  homepage "https://github.com/jrmarino/fetch-freebsd"
  # Upstream does not publish version tags; this fork tracks upstream and tags releases for Homebrew.
  url "https://github.com/laamalif/fetch-freebsd/archive/refs/tags/v14.0.tar.gz"
  sha256 "65ecbde279030d5ad7907a31cecae8a67a0b39db0bfda69f51e59b83fb945d50"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause"]

  depends_on "cmake" => :build
  depends_on "openssl@3" => :build

  conflicts_with "fetch", because: "both install a fetch executable"

  def install
    system "cmake", ".", *std_cmake_args,
           "-DUSE_SYSTEM_SSL=ON",
           "-DOPENSSL_USE_STATIC_LIBS=ON",
           "-DOPENSSL_ROOT_DIR=#{Formula["openssl@3"].opt_prefix}"

    system "make"
    bin.install "program/fetchx" => "fetch"
  end

  test do
    (testpath/"input.txt").write "homebrew-fetchx\n"
    system bin/"fetch", "-o", "output.txt", "file://#{testpath}/input.txt"
    assert_equal "homebrew-fetchx\n", (testpath/"output.txt").read
  end
end
