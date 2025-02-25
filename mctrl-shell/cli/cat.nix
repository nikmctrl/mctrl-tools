{
  config,
  options,
  lib,
  pkgs,
  ...
}:

{
  options.mctrl-shell.cat = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.mctrl-shell = {
    cli = with pkgs; [ bat ];
  };
}
