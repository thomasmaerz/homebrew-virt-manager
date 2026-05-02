class VirtManager < Formula
  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://releases.pagure.org/virt-manager/virt-manager-5.1.0.tar.xz"
  sha256 "ccfc44b6c1c0be8398beb687c675d9ea4ca1c721dfb67bd639209a7b0dec11b1"
  revision 4

  bottle do
    root_url "https://github.com/thomasmaerz/homebrew-virt-manager/releases/download/bottles"
    rebuild 1
    sha256 arm64_sequoia: "d818057f8cd9707503bc108557fe1647a7f71be00de1c0b4235ec29d6d3e13c7"
  end

  depends_on "docutils" => :build
  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "adwaita-icon-theme"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "gtksourceview4"
  depends_on "libosinfo"
  depends_on "libvirt-glib"
  depends_on "libvirt-python"
  depends_on "libxml2"
  depends_on "osinfo-db"
  depends_on "pygobject3"
  depends_on "python@3.14"
  depends_on "spice-gtk"
  depends_on "vte3"

  def install
    system "meson", "setup", "build", *std_meson_args,
           "-Dcompile-schemas=false", "-Dupdate-icon-cache=false"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"

    python_version = Language::Python.major_minor_version Formula["python@3.14"].opt_bin/"python3"
    libvirt_python_path = Formula["libvirt-python"].opt_lib/"python#{python_version}/site-packages"

    # Wrap the meson-installed binaries to inject PYTHONPATH for libvirt bindings
    libexec.install bin
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: "#{libvirt_python_path}:$PYTHONPATH")
  end

  def post_install
    # Compile GSettings schemas manually (skipped during install)
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
    # Update icon cache manually (skipped during install)
    system Formula["gtk+3"].opt_bin/"gtk3-update-icon-cache", HOMEBREW_PREFIX/"share/icons/hicolor"
  end

  test do
    system bin/"virt-manager", "--version"
  end
end
