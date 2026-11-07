class VixSlint < Formula
  desc "Vix desktop GUI on Slint: the full Vix App in a native window."
  homepage "https://github.com/vixide/vix"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-slint-aarch64-apple-darwin.tar.xz"
      sha256 "08aeea1412bbd20e4dea325db62dbf9024cededcf2a7f1315f7553bac6efabe7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-slint-x86_64-apple-darwin.tar.xz"
      sha256 "b56386821c8ae49ec3eb063a34af351920fd36f3c7d221a3388f7c2bf2e1d36f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-slint-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "721a4f8b698e321244364ef66d4c80f26c9309906ebead440d3df8011aa66e02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-slint-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "145b8fbbe631a14d6e2c78c02463caafe56c132c813ae76bf470ade6906d5a2e"
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
