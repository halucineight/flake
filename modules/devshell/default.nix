{ lib, ... }:

{
  options = {
    modules.enableElixirDevShell = lib.mkEnableOption "Elixir dev shell";
  };
}
