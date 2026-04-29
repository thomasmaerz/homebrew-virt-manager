# Phase 2 Modernization Plan

The goal of Phase 2 is to move beyond "fixing the 404s" and into "modern stability and performance."

## 1. Python 3.13 Migration
- [ ] Move `virt-manager` and `libvirt` to `python@3.13`.
- [ ] Update all Python resources in `virt-manager.rb` using `brew update-python-resources`.

## 2. Libvirt 10+ / 11.x
- [ ] Test upstream `libvirt` on Apple Silicon to see if the custom "CPU freq" patch is still necessary.
- [ ] If unnecessary, move to the official stable release and remove the `head` branch dependency on Menci's fork.

## 3. GTK 4 Evaluation
- [ ] Check if `virt-viewer` and `virt-manager` have stable GTK 4 ports that can be leveraged for better macOS performance.

## 4. Bottle Hosting
- [ ] Refine the GitHub Actions workflow to ensure bottles are correctly indexed by Homebrew.
- [ ] Add `bottle do` blocks to formulas once the first set of binaries is generated.

## 5. Better macOS Integration
- [ ] Investigate creating a `.app` bundle wrapper for `virt-manager` so it can be launched from Spotlight/Applications.
