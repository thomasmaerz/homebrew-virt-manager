# virt-manager Homebrew Tap

This repository provides a maintained Homebrew tap for `virt-manager` and related tools on macOS, specifically optimized for Apple Silicon (M1/M2/M3).

## Features
- **Fixed URLs:** No more 404 errors during installation.
- **Binary Support:** Pre-built bottles are automatically generated via GitHub Actions (coming soon).
- **Modernized:** Uses Python 3.12 and updated GTK libraries.

## Installation

```bash
# Add this tap
brew tap thomasmaerz/virt-manager

# Install virt-manager and dependencies
brew install virt-manager virt-viewer gtk-vnc
```

## Running

```bash
# Start libvirt service
brew services start libvirt

# Open virt-manager
virt-manager
```

## Credits
This is a fork and modernization of the abandoned `Menci/homebrew-libvirt-m1` repository.
