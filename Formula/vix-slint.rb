class VixSlint < Formula
  desc "Vix desktop GUI on Slint: the full Vix App in a native window."
  homepage "https://github.com/vixide/vix"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-slint-aarch64-apple-darwin.tar.xz"
      sha256 "2bf8f01ddc7a1f8d8493cb6a9d7a40a27756895d41a3cb3ca0365c4ee4095e5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-slint-x86_64-apple-darwin.tar.xz"
      sha256 "a5b9bd39c8c6fc4f0184a9a31bbe1d6fec0ea364ce10e8feb82e7e80fdd63b5a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-slint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91178c6514f0ae33d1d3a35d6fa3a06bf16e93fa35e5423b3b430dca94687764"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-slint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6cd06611e0056230d235c46284498cf202f6df886cdac78ad31368861a760c4"
    end
  end
  license "GPL-3.0-only"

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
      bin.install "vix-slint"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix-slint"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix-slint"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix-slint"
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
