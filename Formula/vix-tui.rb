class VixTui < Formula
  desc "Vix IDE: a visual integrated development environment that is TUI, friendly, featureful, high-speed, and high-security."
  homepage "https://github.com/vixide/vix"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-tui-aarch64-apple-darwin.tar.xz"
      sha256 "8d86637304ff0ce25676300bda07c05dfdcc19c6b29de94aa08eed1a46993491"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-tui-x86_64-apple-darwin.tar.xz"
      sha256 "b03627f1cb3fbac84340f800cf85da06eefae4f7ec660f07189d523897809dd4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ce2ad051af5e911bc4ec9acdf1370799ae6b82188562063a35ebff1de144db9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vixide/vix/releases/download/2.0.2/vix-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8820d74839d13c95cb035a60c1d0fac6b6fbac4a5f3d0355a4198c42f7679d18"
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
