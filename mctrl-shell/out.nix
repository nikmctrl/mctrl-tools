{
  config,
  options,
  lib,
  ...
}:

{
  imports = [ ./shells ];

  options.out.shell = lib.mkOption {
    type = lib.types.enum [
      "bash"
      "zsh"
      "fish"
      "nushell"
    ];
  };

  config = {
    out.shell = config.shell.program;
  };
}
