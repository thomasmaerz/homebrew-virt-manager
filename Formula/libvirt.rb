class Libvirt < Formula
  desc "C virtualization API"
  homepage "https://libvirt.org/"
  url "https://libvirt.org/sources/libvirt-12.2.0.tar.xz"
  sha256 "ac93cd0da743a6c231911fb549399b415102ecfee775329bebbf61ed843b9786"
  license all_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later"]
  head "https://gitlab.com/Menci/libvirt.git", branch: "v7.10.0-apple-silicon"

  bottle do
    root_url "https://github.com/thomasmaerz/homebrew-virt-manager/releases/download/bottles"
    rebuild 1
    sha256 arm64_sequoia: "715dad6606d9328b393271baf958acec7f382db25ca2fe41cac2e82c2bfd7d19"
  end

  depends_on "docutils" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.12" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "gnu-sed"
  depends_on "gnutls"
  depends_on "grep"
  depends_on "json-c"
  depends_on "libgcrypt"
  depends_on "libiscsi"
  depends_on "libssh2"
  depends_on "qemu"
  depends_on "readline"
  depends_on "yajl"

  uses_from_macos "curl"
  uses_from_macos "libxslt"

  def install
    # Apply apple silicon patch
    inreplace "src/qemu/qemu_command.c", "qemuBuildAccelCommandLine(cmd, def);", ""

    # Patch the install script to avoid creating directories (it fails on macOS)
    # This is the most reliable way to skip the failing part of the install
    inreplace "scripts/meson-install-dirs.py", "import os", "import sys\nsys.exit(0)\nimport os"

    mkdir "build" do
      args = %W[
        --localstatedir=#{var}
        --mandir=#{man}
        --sysconfdir=#{etc}
        -Drunstatedir=#{var}/run
        -Ddriver_esx=enabled
        -Ddriver_qemu=enabled
        -Ddriver_network=enabled
        -Dinit_script=none
        -Dqemu_datadir=#{Formula["qemu"].opt_pkgshare}
      ]
      system "meson", "setup", *std_meson_args, *args, ".."
      system "meson", "compile"
      system "meson", "install"
    end
  end

  service do
    run [opt_sbin/"libvirtd", "-f", etc/"libvirt/libvirtd.conf"]
    keep_alive true
    environment_variables PATH: HOMEBREW_PREFIX/"bin"
  end

  test do
    system "#{bin}/virsh", "-v"
  end
end
