class Yoyak < Formula
  desc "LLM-powered CLI tool for summarizing web pages"
  homepage "https://github.com/dahlia/yoyak"
  license "GPL-3.0"

  version "0.5.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dahlia/yoyak/releases/download/#{version}/yoyak-macos-x86_64.tar.bz2"
      sha256 "00045e84292bb116c0efb9deccb6aef2f147e50cc1183c33ca5e1b0dd06cb195"
    elsif Hardware::CPU.arm?
      url "https://github.com/dahlia/yoyak/releases/download/#{version}/yoyak-macos-aarch64.tar.bz2"
      sha256 "d303579c1b3b8fc3e2e7228ae9601b6d0795a9144171cb8c7d9f2495dd03a2cf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/dahlia/yoyak/releases/download/#{version}/yoyak-linux-x86_64.tar.bz2"
      sha256 "395770624840ebdf0ca91474cf1261ed775bb8508825540a08fc25c49d95c7e9"
    elsif Hardware::CPU.arm?
      url "https://github.com/dahlia/yoyak/releases/download/#{version}/yoyak-linux-aarch64.tar.bz2"
      sha256 "5f601ec16f00c26e6c7b7d63c0aa52e16a240d54a83f80a8e8d0882914530dd6"
    end
  end

  def install
    bin.install "yoyak"

    # Shell completions
    (bash_completion/"yoyak").write Utils.safe_popen_read(bin/"yoyak", "completions", "bash")
    (fish_completion/"yoyak.fish").write Utils.safe_popen_read(bin/"yoyak", "completions", "fish")
    (zsh_completion/"_yoyak").write Utils.safe_popen_read(bin/"yoyak", "completions", "zsh")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yoyak --version")

    # Check if completion files are created
    assert_predicate bash_completion/"yoyak", :exist?
    assert_predicate fish_completion/"yoyak.fish", :exist?
    assert_predicate zsh_completion/"_yoyak", :exist?
  end
end
