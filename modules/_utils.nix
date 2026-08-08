{ lib, ... }:
let
  mkNixosSystem =
    {
      hostname,
      keymap,
      modules,
    }:
    lib.nixosSystem {
      modules = modules ++ [
        ({ ... }: {
          networking.hostName = hostname;
          services.xserver.xkb.layout = keymap;
          environment.variables."XKB_DEFAULT_LAYOUT" = keymap;
          console.useXkbConfig = true;
        })
      ];
    };
in
{
  inherit mkNixosSystem;
}
