{
  options,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.mctrl-shell.zsh;
in
{
  options.mctrl-shell.zsh = {
    enable = lib.mkEnableOption "zsh";
    mainShell = lib.mkOption {
      description = "Whether to set zsh as the main shell, $SHELL";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    out.shells = [ pkgs.zsh ];
    out.mainShell = lib.mkIf cfg.mainShell "${pkgs.zsh}/bin/zsh";
  };
}
