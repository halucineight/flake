{
  lib,
  pkgs ? null,
  localConfig ? { },
  ...
}:

let
  cfg = localConfig.modules or { };
in
{
  module = {
    options = {
      modules.enableElixirDevShell = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Elixir devshell";
      };
      modules.enableRustDevShell = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Rust devshell";
      };
      modules.enableDotnetDevShell = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable dotnet devshell";
      };
    };
  };

  devShells =
    { }
    // lib.optionalAttrs cfg.enableElixirDevShell {
      elixir = pkgs.mkShell {
        packages = with pkgs; [
          elixir
          erlang
          tailwindcss_4
          esbuild
          rebar3
          inotify-tools
          pgcli
          elixir-ls
          tailwindcss-language-server
        ];
      };
    }
    // lib.optionalAttrs cfg.enableRustDevShell {
      rust = pkgs.mkShell {
        packages = with pkgs; [
          cargo
          clippy
          rust-analyzer
          rustc
          rustfmt
        ];
      };
    }
    // lib.optionalAttrs cfg.enableDotNetDevShell {
      dotnet = pkgs.mkShell {
        packages = with pkgs; [
          dotnet-sdk_10
          dotnet-aspnetcore_10
          dotnet-runtime_10
        ];
      };
    };
}
