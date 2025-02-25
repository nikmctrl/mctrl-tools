{
  config,
  options,
  lib,
  pkgs,
  ...
}:

{
  options.ls = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.mctrl-shell = {
    cli = with pkgs; [ eza ];

    aliases = [
      {
        name = "ls";
        value = "eza";
      }
      {
        name = "ll";
        value = "eza -l";
      }
      {
        name = "la";
        value = "eza -la";
      }
    ];
  };
}
