{ pkgs, ... }:

{

  imports = [
    ./developer.nix
    ./devops.nix
  ];

  out.pkgs = with pkgs; [
    just

    eza
    bat
    fd
    fzf
    ripgrep
    sd
    du-dust
    procs
    vim
    aria2
    tmate
    starship

    jq
    yq
    nnn
    rclone

    yai
    navi
  ];
}
