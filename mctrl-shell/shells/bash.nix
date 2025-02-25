{
  options,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.bash;
in
{
  options.mctrl-shell.bash = {
    enable = lib.mkEnableOption "bash";
    mainShell = lib.mkOption {
      description = "Whether to set bash as the main shell, $SHELL";
      type = lib.types.bool;
      default = false;
    };
  };

  config.out = lib.mkIf cfg.enable {
    shells = [ pkgs.bashInteractive ];

    out.mainShell = lib.mkIf cfg.mainShell "${pkgs.bashInteractive}/bin/bash";

  };
}
