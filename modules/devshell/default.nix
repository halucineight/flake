{ lib, ... }:

{
  options = {
    modules.enableElixirDevShell = lib.mkEnableOption "Elixir dev shell";
    modules.enableRustDevShell = lib.mkEnableOption "Rust dev shell";
  };
}
