#!/usr/bin/env bash
set -euo pipefail

git clone --depth 1 https://github.com/nix-community/disko /tmp/disko

sudo nix run path:/tmp/disko \
  --extra-experimental-features 'nix-command flakes' \
  --option extra-substituters 'https://cache.nixos.org https://nix-community.cachix.org' \
  --option extra-trusted-public-keys 'nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=' \
  --option connect-timeout 5 \
  --option stalled-download-timeout 30 \
  --option download-attempts 5 \
  -- --mode disko --flake 'path:/tmp/flake#ph315'

sudo nixos-install --flake 'path:/tmp/flake#ph315'
reboot
