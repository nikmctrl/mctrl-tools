{ pkgs, lib, ... }:

{
  options.out = {
    pkgs = lib.mkOption { type = lib.types.listOf lib.types.package; };

    aliases = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption { type = lib.types.string; };
            value = lib.mkOption { type = lib.types.string; };
          };
          # TODO: Add default aliases
          # config = {
          # name = "alias";
          # value = "alias";
          # };

        }
      );
      files = lib.mkOption { type = lib.types.attrsOf lib.types.string; };
    };
  };

  config = {
    # out.pkgs = [ ];
    out.aliases = [
      {
        name = "alias";
        value = "alias";
      }
    ];

  };
}
