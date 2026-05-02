# virt-manager Homebrew Tap

A Homebrew tap providing `virt-manager` and related tools for macOS on Apple Silicon (M-series), built and tested on macOS 15 Sequoia.

## Included formulae

| Formula | Version | Command(s) |
|---|---|---|
| `virt-manager` | 5.1.0 | `virt-manager` |
| `virt-viewer` | 11.0 | `virt-viewer` |
| `gtk-vnc` | 1.5.0 | `gvnccapture` |
| `libvirt` | 12.2.0 | `virsh`, `libvirtd` |

Pre-built bottles are available for **arm64_sequoia** (Apple Silicon, macOS 15). Other platforms will build from source.

## Requirements

- Apple Silicon Mac (M1 or later)
- macOS 15 Sequoia
- [QEMU](https://www.qemu.org/) (installed automatically as a dependency)

## Installation

```bash
# Add this tap
brew tap thomasmaerz/virt-manager

# Install virt-manager and virt-viewer (pulls in libvirt, gtk-vnc, and all other deps)
brew install virt-manager virt-viewer
```

## Usage

```bash
# Start the libvirt daemon
brew services start libvirt

# Launch virt-manager (GUI)
virt-manager

# Or use the CLI
virsh list --all
```

## Credits

Fork and modernization of the abandoned [`Menci/homebrew-libvirt-m1`](https://github.com/Menci/homebrew-libvirt-m1) repository.
