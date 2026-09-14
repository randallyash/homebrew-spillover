class Spill < Formula
  desc "Agentic AI TUI that spills over across local and hosted models when a tier stalls"
  homepage "https://github.com/randallyash/spillover"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.2.0/spill-aarch64-apple-darwin.tar.xz"
      sha256 "55533fde821fba5e2b98674d25250900257df179245b8572e8e5c7ca1a8662bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.2.0/spill-x86_64-apple-darwin.tar.xz"
      sha256 "4bdca5dbfefb246dca3fd66787c0d16fc24a5c1a402187bd5bfdfd17268784eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.2.0/spill-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "66f2c58e4112c90967cdc989b4965607892a6d1c3f17f45a8ebb1a79e6fa2feb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.2.0/spill-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b529095103f1476bdcb729294c8db3376302b034b96c030ab865206b79f158dd"
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
