{
  config,
  lib,
  pkgs,
  ...
}:

with pkgs;
let
  elixirGlobalDeps = lib.optionals config.modules.enableElixirDevShell [
    elixir-ls
    tailwindcss-language-server
  ];

in
elixirGlobalDeps
