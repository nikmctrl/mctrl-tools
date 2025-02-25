{ pkgs, ... }:

{
  out.pkgs = with pkgs; [
    zsh
    # fish
    # nu
  ];

  out.files = {
    ".zshrc" = builtins.readFile ./configs/zshrc;
  };
}
