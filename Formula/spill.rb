class Spill < Formula
  desc "Agentic AI TUI that spills over across local and hosted models when a tier stalls"
  homepage "https://github.com/randallyash/spillover"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.1/spill-aarch64-apple-darwin.tar.xz"
      sha256 "47288b5d68f25b50c055d551ecc6ebb16a57f3f62ab512840b47b9980dcb7802"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.1/spill-x86_64-apple-darwin.tar.xz"
      sha256 "17c6bc08ed5f9cd7e3255c782861795e29be8182f5d0891be1ece001af3f199c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.1/spill-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "24e8aff16a70aae9d7dba6f055e47ab36fc94e4e1d95e2582006cbb545a7615f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.1/spill-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44d0c4dab52be3a6a5415f3d75be4531336761a9f66c73cd620755cd06407dad"
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
