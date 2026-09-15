class Spill < Formula
  desc "Agentic AI TUI that spills over across local and hosted models when a tier stalls"
  homepage "https://github.com/randallyash/spillover"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.4.0/spill-aarch64-apple-darwin.tar.xz"
      sha256 "39151f8cd818dd3b4079a4c2569d5a641cf1b5d6d274816008bca61b20829f82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.4.0/spill-x86_64-apple-darwin.tar.xz"
      sha256 "f241213117bea460893d9235f8929f54a90dc888d3cd30cb9398ca86cf50c467"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randallyash/spillover/releases/download/v0.4.0/spill-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3640b66e3e3789f3aa747e5e0d4d5f4a0f4c725fc9b59e818a430093777be30a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randallyash/spillover/releases/download/v0.4.0/spill-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e836adcea383d5ea59bfe347c0afc7189f02bbde99a7fc42f1e6144dd332beab"
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
