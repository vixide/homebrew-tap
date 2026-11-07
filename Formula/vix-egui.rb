class VixEgui < Formula
  desc "Vix desktop GUI on egui (eframe): the full Vix App in a native window."
  homepage "https://github.com/vixide/vix"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-egui-aarch64-apple-darwin.tar.xz"
      sha256 "a3491299a3e004a118f2b181b04749a9ae14bc9c5911d3b5d72300cd9edc380e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-egui-x86_64-apple-darwin.tar.xz"
      sha256 "fce9ea42cc251425e541a5de9b3460934b1c8fd7b26d76311e9799963fd986e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-egui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "72f5d03b004e0e5c81f4afcce635792a39ed021e5c13390480bff988be6106cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-egui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b09680fcc5b8e14b8ac28d772b6d7dcd41e36c6608e0bc025718f26564547c2"
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
      bin.install "vix-egui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix-egui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix-egui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix-egui"
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
