{
  config,
  options,
  lib,
  ...
}:

{
  options.aliases = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
    example = [
      {
        name = "ls";
        value = "eza";
      }
    ];
  };

  config.mctrl-shell.aliases = [ ];
}
