{ config
, lib
, pkgs
, ...
}:

with pkgs;
lib.optional config.modules.enableElixirDevShell elixir-ls
