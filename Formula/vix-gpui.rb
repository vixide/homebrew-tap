class VixGpui < Formula
  desc "Vix desktop GUI on GPUI (GPUI Kit): the full Vix App in a native GPU-rendered window."
  homepage "https://github.com/vixide/vix"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-gpui-aarch64-apple-darwin.tar.xz"
      sha256 "eb55f73a07d0711625424c158b778ad575f6da2cc92a5709e63bda1b06b68842"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-gpui-x86_64-apple-darwin.tar.xz"
      sha256 "14456d43b62bbf9d13bc415f7e2650ec5be5ebc6f7711bb8bc04511ccbefc9e5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-gpui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fbb9f33de65eb66ffeceb3a429a515975e6b82a7cc09c854799973971e5f12ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-gpui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7d7f5a065081f122bb4787e87e34accdbd8c3a81409afdd16ee0b185df9b12b"
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
