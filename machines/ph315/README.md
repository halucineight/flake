# `ph315` reinstall

```sh
git clone https://github.com/halucineight/flake /tmp/flake
cp /tmp/flake/local.nix.example /tmp/flake/local.nix
vim /tmp/flake/local.nix
sudo nix run github:nix-community/disko -- --mode disko --flake 'path:/tmp/flake#ph315'
sudo nixos-install --flake 'path:/tmp/flake#ph315'
reboot
```
