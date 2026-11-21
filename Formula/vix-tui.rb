class VixTui < Formula
  desc "Vix IDE: a visual integrated development environment that is TUI, friendly, featureful, high-speed, and high-security."
  homepage "https://github.com/vixide/vix"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-tui-aarch64-apple-darwin.tar.xz"
      sha256 "2491fbb58fd37a0090b4a383b028765e514842799ab8be455e300548d1931763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-tui-x86_64-apple-darwin.tar.xz"
      sha256 "09fa663e00319ec8cc2527fe4a3834dff7189d15a55306cba7460a4ccde2ba12"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a33ba62ed1495d03f83b048e43db763e570b81f1be25165824d77b63a54c068"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.1.0/vix-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "261aa150b3def374655a092901df2fb1b4582386d25e95a69ceed6031601617f"
    end
  end
  license any_of: ["Apache-2.0", "BSD-3-Clause", "MIT", "GPL-3.0-only"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-pc-windows-gnu":            {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
      bin.install "vix"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vix"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vix"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vix"
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
