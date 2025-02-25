{
  options,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.fish;
in
{
  options.mctrl-shell.fish = {
    enable = lib.mkEnableOption "fish";

    mainShell = lib.mkOption {
      description = "Whether to set fish as the main shell, $SHELL";
      type = lib.types.bool;
      default = false;
    };

    # config_fish = lib.mkOption {
    #   description = "Whether to configure fish";
    #   type = lib.types.listOf lib.types.str;
    #   default = [
    #     "set -g fish_greeting"
    #     "set -g fish_prompt_pwd_dir_length 0"
    #     "set -g fish_prompt_pwd_dir_length 0"
    #     "set -g fish_prompt_pwd_dir_length 0"
    #     "set -g fish_prompt_pwd_dir_length 0"
    #   ];
    # };
  };

  config = lib.mkIf cfg.enable {
    out.shells = [ pkgs.fish ];
    out.mainShell = lib.mkIf cfg.mainShell "${pkgs.fish}/bin/fish";

    out.config_fish = cfg.config_fish;
  };
}
