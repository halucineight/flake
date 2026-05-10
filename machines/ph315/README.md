# `ph315` reinstall

1. git clone https://github.com/halucineight/flake /tmp/flake
2. cp /tmp/flake/local.nix.example /tmp/flake/local.nix
3. vim /tmp/flake/local.nix

4. cd /tmp/flake
5. nix flake metadata
6. nix flake check --no-build

7. git clone --depth 1 https://github.com/nix-community/disko /tmp/disko

8. sudo nix run path:/tmp/disko \
  --extra-experimental-features 'nix-command flakes' \
  --option extra-substituters 'https://cache.nixos.org https://nix-community.cachix.org' \
  --option extra-trusted-public-keys 'nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=' \
  --option connect-timeout 5 \
  --option stalled-download-timeout 30 \
  --option download-attempts 5 \
  -- --mode disko --flake 'path:/tmp/flake#ph315'

9. sudo nixos-install --flake 'path:/tmp/flake#ph315'
10. reboot
