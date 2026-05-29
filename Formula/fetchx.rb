class Fetchx < Formula
  desc "FreeBSD fetch utility (portable CLI downloader)"
  homepage "https://github.com/jrmarino/fetch-freebsd"
  url "https://github.com/laamalif/fetch-freebsd/archive/refs/tags/v14.0.tar.gz"
  sha256 "65ecbde279030d5ad7907a31cecae8a67a0b39db0bfda69f51e59b83fb945d50"

  depends_on "cmake" => :build
  depends_on "openssl@3" => :build

  def install
    system "cmake", ".", *std_cmake_args,
           "-DUSE_SYSTEM_SSL=ON",
           "-DOPENSSL_USE_STATIC_LIBS=ON",
           "-DOPENSSL_ROOT_DIR=#{Formula["openssl@3"].opt_prefix}"

    system "make"
    bin.install "program/fetchx" => "fetch"
  end
end
