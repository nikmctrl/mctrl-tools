{ lib, ... }:

{
  options.out = {
    pkgs = lib.mkOption { type = lib.types.listOf lib.types.package; };

    aliases = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.string);
      example = [
        {
          name = "alias";
          value = "alias";
        }
      ];
    };

    files = lib.mkOption {
      type = lib.types.attrsOf lib.types.string;
      example = {
        ".zshrc" = builtins.readFile ./configs/zshrc;
      };
    };
  };

  config = rec {
    out.pkgs = [ ];

    out.aliases = [
      {
        name = "ls";
        value = "eza";
      }
    ];

    out.files = {
      ".aliases.zsh" = lib.concatStringsSep "\n" (
        map ({ name, value }: "alias ${name}=${value}") out.aliases
      );
    };
  };
}
