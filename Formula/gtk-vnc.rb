class GtkVnc < Formula
  desc "VNC viewer widget for GTK"
  homepage "https://gitlab.gnome.org/GNOME/gtk-vnc"
  url "https://download.gnome.org/sources/gtk-vnc/1.5/gtk-vnc-1.5.0.tar.xz"
  sha256 "c0beb4747528ad931da43acc567c6a0190f7fc624465571ed9ccece02c34dd23"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://github.com/thomasmaerz/homebrew-virt-manager/releases/download/bottles"
    rebuild 2
    sha256 arm64_sequoia: "59408a59f0e1d2b6e74b0e6c0b987b38981df22cfa3657a0732a2b7cb11d25fe"
  end

  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gnutls"
  depends_on "gtk+3"
  depends_on "libgcrypt"

  def install
    mkdir "build" do
      # Use gthread coroutines on macOS to avoid deprecated ucontext
      system "meson", *std_meson_args, "-Dwith-coroutine=gthread", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "#{bin}/gvnccapture", "--help"
  end
end
