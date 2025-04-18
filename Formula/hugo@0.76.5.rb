class Hugo < Formula
  desc "Configurable static site generator"
  homepage "https://gohugo.io/"
  url "https://github.com/gohugoio/hugo/archive/v0.76.5.tar.gz"
  sha256 "9ab9894b3fa5e21fe3c271a8de4724b5185bbfb8c41783e623b9f4d654352af9"
  license "Apache-2.0"
  head "https://github.com/gohugoio/hugo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c2e1dabe1ed02130af250f611be4245fce9404ed8d9060451109a803ceb72911" => :catalina
    sha256 "b998eb72219b72ad4c20856dbfa41e28038a23aac5b54b3035a9d85ef0c06e27" => :mojave
    sha256 "c65fe457060906d8c250c57d1cd72177e12311c210c940b02f603e3e58e3e7e5" => :high_sierra
    sha256 "dcac0e6a2674de5d0bb99b1c31d81ae1dc5762dd5e989c7f7378f7d56b2b142f" => :catalina
    sha256 "a68cba474c4e43857fd2eab731c502ced85d386cd9638d184a121c1c046c54ff" => :mojave
    sha256 "61e2f8bb4a8e25663aea94350670cf1265db113edcc61abefc5948b4eb60dc64" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    (buildpath/"src/github.com/gohugoio/hugo").install buildpath.children

    cd "src/github.com/gohugoio/hugo" do
      system "go", "build", "-o", bin/"hugo", "-tags", "extended", "main.go"

      # Build bash completion
      system bin/"hugo", "gen", "autocomplete", "--completionfile=hugo.sh"
      bash_completion.install "hugo.sh"

      # Build man pages; target dir man/ is hardcoded :(
      (Pathname.pwd/"man").mkpath
      system bin/"hugo", "gen", "man"
      man1.install Dir["man/*.1"]

      prefix.install_metafiles
    end
  end
end
