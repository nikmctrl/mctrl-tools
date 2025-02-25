{ pkgs, lib, ... }:

pkgs.lib.evalModules {
  modules = [
    ./shells.nix
    ./tools
    ./out.nix
  ];
}
