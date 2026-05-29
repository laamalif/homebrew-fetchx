class Fetchx < Formula
  desc "FreeBSD fetch utility (portable CLI downloader)"
  homepage "https://github.com/jrmarino/fetch-freebsd"
  # Upstream does not publish version tags; this fork tracks upstream and tags releases for Homebrew.
  url "https://github.com/laamalif/fetch-freebsd/archive/refs/tags/v14.0.tar.gz"
  sha256 "65ecbde279030d5ad7907a31cecae8a67a0b39db0bfda69f51e59b83fb945d50"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause"]
  revision 1

  depends_on "cmake" => :build
  depends_on "openssl@3"

  conflicts_with "fetch", because: "both install a fetch executable"

  def install
    openssl = Formula["openssl@3"]

    inreplace "program/CMakeLists.txt" do |s|
      s.gsub! "set (libssl ssl)", "set (libssl #{openssl.opt_lib/shared_library("libssl")})"
      s.gsub! "set (libcrypto crypto)", "set (libcrypto #{openssl.opt_lib/shared_library("libcrypto")})"
      s.gsub! 'set (incssl "")', "set (incssl #{openssl.opt_include})"
    end

    system "cmake", ".", *std_cmake_args,
           "-DUSE_SYSTEM_SSL=ON"

    system "make"
    bin.install "program/fetchx" => "fetch"
  end

  test do
    (testpath/"input.txt").write "homebrew-fetchx\n"
    system bin/"fetch", "-o", "output.txt", "file://#{testpath}/input.txt"
    assert_equal "homebrew-fetchx\n", (testpath/"output.txt").read
  end
end
