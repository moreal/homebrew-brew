class Seonbi < Formula
  desc "LLM-powered CLI tool for summarizing web pages"
  homepage "https://github.com/dahlia/seonbi"
  license "LGPL-2.1"

  version "0.5.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dahlia/seonbi/releases/download/#{version}/seonbi-#{version}.macos-x86_64.tar.bz2"
      sha256 "209707c69a178a2f6d939bbe1b883d5872f8a3dd1c9b8e3f2e58769c5f466b25"
    elsif Hardware::CPU.arm?
      url "https://github.com/dahlia/seonbi/releases/download/#{version}/seonbi-#{version}.macos-arm64.tar.bz2"
      sha256 "7c3a9dad32490b4a99e09c9d9e231b43c27eeb213004973ce62f68b391daa55d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/dahlia/seonbi/releases/download/#{version}/seonbi-#{version}.linux-x86_64.tar.bz2"
      sha256 "bf4e92507bd0e08d963c838c269070633f0bcd04347a50008c4256c0aa9e5b1b"
    elsif Hardware::CPU.arm?
      url "https://github.com/dahlia/seonbi/releases/download/#{version}/seonbi-#{version}.linux-arm64.tar.bz2"
      sha256 "aa18b3845d9a8cd79e29c0b06578507481617f1a570cae626ddb5cf6f4fd9149"
    end
  end

  def install
    bin.install "seonbi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/seonbi --version")
  end
end
