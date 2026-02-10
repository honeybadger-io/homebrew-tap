class Hbtui < Formula
  desc "Terminal dashboard for Honeybadger.io"
  homepage "https://www.honeybadger.io"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.1/hbtui-aarch64-apple-darwin.tar.xz"
      sha256 "bcce34db75d8dbb702041facaca52df0224aa4c8ee45bede188ce5eb46f2fd0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.1/hbtui-x86_64-apple-darwin.tar.xz"
      sha256 "5347ee23222a78c79d07d6346b8f2ec7bada8502daa00edcfeff621dce22c567"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.1/hbtui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63be1b74ec63c146c5080546e9b1954429b85949886fb7921e62d9324d175b84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.1/hbtui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6149d33dbece14432bd0f92266b66ae88003269eaff83b35fbd652a9932aa41"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "hbtui" if OS.mac? && Hardware::CPU.arm?
    bin.install "hbtui" if OS.mac? && Hardware::CPU.intel?
    bin.install "hbtui" if OS.linux? && Hardware::CPU.arm?
    bin.install "hbtui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
