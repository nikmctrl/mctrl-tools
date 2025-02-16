{
  description = "A collection of MissionCtrl's pre-configured tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mctrl-formatter.url = "github:nikmctrl/mctrl-formatter?ref=git-hooks";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs = { self, nixpkgs, mctrl-formatter, pre-commit-hooks, ... }: let 
    base = mctrl-formatter.outputs;
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in base // (forAllSystems (system: {
    checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = self.mctrl-hooks;
        };
      };

      devShells = {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      };
    })
  );
}
