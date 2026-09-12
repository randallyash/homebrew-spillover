class Spill < Formula
  desc "Agentic AI TUI that spills over across local and hosted models when a tier stalls"
  homepage "https://github.com/randallyash/spillover"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.2/spill-aarch64-apple-darwin.tar.xz"
      sha256 "68f0ca84e1ffd61416bf25d637a20f3d51f0bf0bc17aeb098d3fa79c747bc884"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.2/spill-x86_64-apple-darwin.tar.xz"
      sha256 "9f4b93c655f4bf154828a521cf41b0080edf78f4bfdcf80f57c93ec4c77da68d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.2/spill-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "53cae3a2056e48e2469d2b691d91545de0d73d73ba7e5b0e9891d0f05650a1eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.1.2/spill-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "42884e95f70ddfea17bf42374bc31281b81602877d0435b0783374e1ce33d57c"
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
