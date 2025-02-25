{
  options,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nushell;
in
{
  options.mctrl-shell.nushell = {
    enable = lib.mkEnableOption "nushell";

    mainShell = lib.mkOption {
      description = "Whether to set nushell as the main shell, $SHELL";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    out.shells = [ pkgs.nushell ];
    out.mainShell = lib.mkIf cfg.mainShell "${pkgs.nushell}/bin/nu";
  };
}
