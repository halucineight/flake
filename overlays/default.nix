{
  nixpkgs.overlays = [
    (final: prev:
      let
        overrideCliHelpers =
          pyPkgs:
          pyPkgs.overrideScope (_: pyPrev: {
            cli-helpers = pyPrev.cli-helpers.overridePythonAttrs (_: rec {
              version = "2.14.0";
              src = pyPrev.fetchPypi {
                pname = "cli_helpers";
                inherit version;
                hash = "sha256-eY4HMfL01CV2fLEqOtlmvyi13nelZRZiBhu0pmvujzU=";
              };
            });
          });
      in
      {
        python3Packages = overrideCliHelpers prev.python3Packages;
        python313Packages = overrideCliHelpers prev.python313Packages;
      })
  ];
}
