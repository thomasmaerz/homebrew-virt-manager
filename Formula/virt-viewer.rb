class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://releases.pagure.org/virt-viewer/virt-viewer-11.0.tar.xz"
  sha256 "a43fa2325c4c1c77a5c8c98065ac30ef0511a21ac98e590f22340869bad9abd0"

  bottle do
    root_url "https://github.com/thomasmaerz/homebrew-virt-manager/releases/download/bottles"
    sha256 arm64_sequoia: "29a6086a08cdeda73b9f9bd499317db3ce124fe15cec4091ce558c55a0b7dcf5"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "libxml2"
  depends_on "pango"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"

  def install
    # Fix compatibility with modern Meson by removing positional arguments from i18n.merge_file
    inreplace "data/meson.build", "i18n.merge_file (\n    desktop,", "i18n.merge_file(\n"
    inreplace "data/meson.build", "i18n.merge_file (\n    mimetypes,", "i18n.merge_file(\n"
    inreplace "data/meson.build", "i18n.merge_file (\n    metainfo,", "i18n.merge_file(\n"

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja", "install"
    end
    # Remove generated mime cache files to avoid symlink conflict
    # with shared-mime-info. The mime db is regenerated in post_install.
    Dir["#{share}/mime/*"].each { |f| rm f if !File.directory?(f) && !f.end_with?("packages") }
  end

  def post_install
    # manual update of mime database
    system "#{Formula["shared-mime-info"].opt_bin}/update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
    # manual icon cache update step
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system bin/"virt-viewer", "--version"
  end
end
