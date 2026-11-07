class VixIced < Formula
  desc "Vix desktop GUI on iced: the full Vix App in a native window."
  homepage "https://github.com/vixide/vix"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-iced-aarch64-apple-darwin.tar.xz"
      sha256 "095eacbe4157f0d6125aecf5849c006a9c37c61882edffcb3ace238b9043c6b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-iced-x86_64-apple-darwin.tar.xz"
      sha256 "7279a14426296691542252d939b0be34132cbe5d57876aab37a5f7d93c20742f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-iced-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a668c534fd4b051dbff081009b03ef74783f311503c0a9a5138ad88ecf18547"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-iced-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb4e9eb6a7e634b90221a7bfc36228208a4ad7ab6006708bcaf742f7b015db56"
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
      bin.install "vix-iced"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix-iced"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix-iced"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix-iced"
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
