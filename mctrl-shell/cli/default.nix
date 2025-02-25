{
  config,
  options,
  lib,
  ...
}:

{
  imports = [ ./ls.nix ];

  options.mctrl-shell.cli = lib.mkOption { type = lib.types.listOf lib.types.package; };

  config.mctrl-shell = {
    cli = [ ];
  };

}
