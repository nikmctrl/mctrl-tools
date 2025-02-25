{ inputs, pkgs, ... }:
let
  out = inputs.nixpkgs.lib.evalModules {
    specialArgs = { inherit pkgs inputs; };
    modules = [
      ./shells.nix
      ./tools
      ./out.nix
    ];
  };
in
pkgs.mkShell {
  buildInputs = out.config.out.pkgs;

  shellHook = ''
    zsh

    source ${out.config.out.files.".zshrc"}\n\n\n
    source ${out.config.out.files.".aliases.zsh"}\n\n\n
  '';
}
