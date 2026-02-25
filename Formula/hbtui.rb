class Hbtui < Formula
  desc "Terminal dashboard for Honeybadger.io"
  homepage "https://www.honeybadger.io"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.2/hbtui-aarch64-apple-darwin.tar.xz"
      sha256 "3a69cb5365046de1cd6d109a7b113c52ce1366b65dd146ac0e8a29bca9f35c69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.2/hbtui-x86_64-apple-darwin.tar.xz"
      sha256 "8deee7bae98a96a6fe874a2cfed4678aad7a38ad8d54ea4c2d2264f536093137"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.2/hbtui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b88c3166f7fa229aa0580ef4999f6ba2bc5c7a268753ea711f10dd96c861d2ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/honeybadger-io/hbtui/releases/download/v0.0.2/hbtui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9072ab1751ad00bd7cff79833ed3da447be75bf40aeff822d490650105ab8b8e"
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
