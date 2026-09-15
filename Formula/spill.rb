class Spill < Formula
  desc "Agentic AI TUI that spills over across local and hosted models when a tier stalls"
  homepage "https://github.com/randallyash/spillover"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.3.0/spill-aarch64-apple-darwin.tar.xz"
      sha256 "a25549ea63c21ed45b1d72fb730fdd5dbd99ce1261d6bdd8678e55424744dcaf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.3.0/spill-x86_64-apple-darwin.tar.xz"
      sha256 "bcd75716b4a322a0ae9d541efc2eaf6b00142f374c2485cb7c844991c8a6c721"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.3.0/spill-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a532c09b48fe280f1c652554b715b2f24835c8d73911f26bf4cdd0397e078caa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.3.0/spill-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c4f35319d8e107a5b2a747ff3861af0b8463857a9a88c1c4ff0644cc85244a1c"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "spill"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "spill"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "spill"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "spill"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
