{
  description = "A collection of MissionCtrl's pre-configured tools";

  nixConfig = {
    extra-substituters = [ "https://nikmctrl.cachix.org" ];
    extra-trusted-public-keys = [
      "nikmctrl.cachix.org-1:W91Ki7qcSFa1E3krRGlilwh7qyfui0cx7Bdj6wwOgvA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mctrl-formatter.url = "github:nikmctrl/mctrl-formatter";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    flake-schemas.url = "github:DeterminateSystems/flake-schemas";
    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs =
    {
      self,
      nixpkgs,
      mctrl-formatter,
      pre-commit-hooks,
      flake-schemas,
      flake-utils,
      ...
    }:

    flake-utils.lib.eachDefaultSystem (system: {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            mctrl-formatter = {
              enable = true;

              name = "MissionCtrl Formatter";

              entry = "${mctrl-formatter.packages.${system}.mctrl-formatter}/bin/treefmt";

              language = "system";
            };
          };
        };
      };

      devShells = {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      };
    })
    // {
      inherit (mctrl-formatter) formatter packages;

      inherit (flake-schemas) schemas;
    };
}
