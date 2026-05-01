class VirtManager < Formula
  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://releases.pagure.org/virt-manager/virt-manager-5.1.0.tar.xz"
  sha256 "ccfc44b6c1c0be8398beb687c675d9ea4ca1c721dfb67bd639209a7b0dec11b1"

  depends_on "docutils" => :build
  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "adwaita-icon-theme"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "gtksourceview4"
  depends_on "libosinfo"
  depends_on "libvirt-glib"
  depends_on "libxml2"
  depends_on "osinfo-db"
  depends_on "pygobject3"
  depends_on "python@3.12"
  depends_on "spice-gtk"
  depends_on "vte3"

  def install
    system "meson", "setup", "build", *std_meson_args, "-Dcompile-schemas=false", "-Dupdate-icon-cache=false"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  def post_install
    # manual schema compile step
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
    # manual icon cache update step
    system Formula["gtk+3"].opt_bin/"gtk3-update-icon-cache", HOMEBREW_PREFIX/"share/icons/hicolor"
  end

  test do
    system bin/"virt-manager", "--version"
  end
end
