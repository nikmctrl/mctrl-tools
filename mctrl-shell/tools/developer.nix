{ pkgs, ... }:

{
  out.pkgs = with pkgs; [
    git-ignore
    git
    git-extras
  ];

}
