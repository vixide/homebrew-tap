class VixGpui < Formula
  desc "Vix desktop GUI on GPUI (GPUI Kit): the full Vix App in a native GPU-rendered window."
  homepage "https://github.com/vixide/vix"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-gpui-aarch64-apple-darwin.tar.xz"
      sha256 "917c787a7542bcacb691f0ab2cee158fdef96fe7e5625a8b528cf9796921bc57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-gpui-x86_64-apple-darwin.tar.xz"
      sha256 "fa426d22baa6d4affee1c10d8ec9425ca911466946254b8ab299d48ffca42a6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-gpui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd445d0ab41435721ead760f4db4bfcb195cd790fe6b9fd4a7b3a498ff3e1771"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-gpui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e0d786a53d7eb1b0c1b714bfe115acf89874e21e09443d4b3aae40e729cc5582"
    end
  end
  license any_of: ["Apache-2.0", "BSD-3-Clause", "MIT", "GPL-3.0-only"]

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
      bin.install "vix-gpui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix-gpui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix-gpui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix-gpui"
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
