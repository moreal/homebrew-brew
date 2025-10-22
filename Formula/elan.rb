class Elan < Formula
  desc "The Lean version manager"
  homepage "https://github.com/leanprover/elan"
  license "MIT"

  version "4.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/leanprover/elan/releases/download/v#{version}/elan-x86_64-apple-darwin.tar.gz"
      sha256 "368755cfc86f382b88427d57bd0bdbd1e2a14cf385e2d331bf5ab79f5975d1f9"
    elsif Hardware::CPU.arm?
      url "https://github.com/leanprover/elan/releases/download/v#{version}/elan-aarch64-apple-darwin.tar.gz"
      sha256 "79f4c33e497cd50864de2388fafff43f7ca98bd27f63847fb6a6b59102ae1fd1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/leanprover/elan/releases/download/v#{version}/elan-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f81c2e48c1588d4612cd2c8851947898a45ac8d72748a07dff3a5694f1cf589b"
    elsif Hardware::CPU.arm?
      url "https://github.com/leanprover/elan/releases/download/v#{version}/elan-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd69d970f615ebe74e2a54cd193f8b7471d1d5facef624808f14f290dec8ee62"
    end
  end

  def install
    bin.install "elan-init"

    # Run elan-init to install elan and toolchains
    system bin/"elan-init", "-y", "--no-modify-path"

    # Create symlinks for elan binaries
    bin.install_symlink Dir["#{Dir.home}/.elan/bin/*"]
  end

  def uninstall_postflight
    # Remove elan installation directory
    FileUtils.rm_rf("#{Dir.home}/.elan")
  end

  def caveats
    <<~EOS
      elan has been installed and initialized automatically.

      The elan command is now available. To get started:
        elan show                   # Show active toolchain
        elan install <toolchain>    # Install a specific Lean version
        elan default <toolchain>    # Set default toolchain

      Lean toolchains are installed in ~/.elan
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/elan-init --version")
  end
end
