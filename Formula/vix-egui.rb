class VixEgui < Formula
  desc "Vix desktop GUI on egui (eframe): the full Vix App in a native window."
  homepage "https://github.com/vixide/vix"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-egui-aarch64-apple-darwin.tar.xz"
      sha256 "649a750e543cc7604cd95440a9e3d3015866a71d2e9ad291c2cc52033304d7cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-egui-x86_64-apple-darwin.tar.xz"
      sha256 "25f2c40efe96371347dc907b38795fc0d3f26b062be3f7a68acf435c29b3b7d0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-egui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "72ee8e6f9ca473860bc1cdadef83eccbca5804b92e0101336376a98fd70f0203"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-egui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98d4e841f35cc952fa5fab3ad4dac7d621083c9b9ebc6e14b0b6002c07a75f7a"
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
