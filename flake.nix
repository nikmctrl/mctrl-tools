{
  description = "A collection of MissionCtrl's pre-configured tools";

  nixConfig = {
    extra-substituters = [
      "https://nikmctrl.cachix.org"
      "https://om.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nikmctrl.cachix.org-1:W91Ki7qcSFa1E3krRGlilwh7qyfui0cx7Bdj6wwOgvA="
      "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mctrl-formatter.url = "github:nikmctrl/mctrl-formatter";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    flake-utils.url = "github:numtide/flake-utils";
    flake-schemas.url = "github:DeterminateSystems/flake-schemas";
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

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
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
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs =
              self.checks.${system}.pre-commit-check.enabledPackages
              ++ (with pkgs; [
                just
                zsh
              ]);
          };
          mctrl-shell = pkgs.mkShell { buildInputs = [ self.packages.${system}.mctrl-shell ]; };
        };
      }
    )
    // {
      inherit (mctrl-formatter) formatter packages;

      inherit (flake-schemas) schemas;

      inherit (self.packages.aarch64-darwin) mctrl-shell;
    };
}
