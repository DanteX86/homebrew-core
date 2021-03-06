class Neomutt < Formula
  desc "E-mail reader with support for Notmuch, NNTP and much more"
  homepage "https://www.neomutt.org/"
  url "https://github.com/neomutt/neomutt/archive/neomutt-20180223.tar.gz"
  sha256 "10ba010017cf7db6bb5ac3e2116d6defad56d34be0dceea9d70a66d8510927bb"
  revision 1
  head "https://github.com/neomutt/neomutt.git"

  bottle do
    sha256 "33f583331446ba0ef8182f9012582ea78cf8744f892b6503f2fbafdfba93a1b1" => :high_sierra
    sha256 "d6217664b0b41cd8203006f18586997465c6cfc829978fd63c830e7dda3ace52" => :sierra
    sha256 "c32e278abf1a8a69cb5e0c5976bb140db3dd941cd1c40ccbc6adac9987ba84e8" => :el_capitan
  end

  depends_on "docbook-xsl" => :build
  depends_on "gettext"
  depends_on "gpgme"
  depends_on "libidn"
  depends_on "lmdb"
  depends_on "notmuch"
  depends_on "openssl"
  depends_on "tokyo-cabinet"

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "./configure", "--prefix=#{prefix}",
                          "--enable-gpgme",
                          "--gss",
                          "--lmdb",
                          "--notmuch",
                          "--sasl",
                          "--tokyocabinet",
                          "--with-ssl=#{Formula["openssl"].opt_prefix}",
                          "--with-ui=ncurses"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/neomutt -F /dev/null -Q debug_level")
    assert_equal "debug_level=0", output.chomp
  end
end
