{ inputs, lib, userProfiles }:
let
  validUsernames = builtins.attrNames userProfiles;

  mkNixosSystem =
    {
      hostname,
      keymap,
      modules,
      enableUsers ? [ ],
    }:
    let
      invalidUsers = lib.filter (name: !lib.elem name validUsernames) enableUsers;
    in
    if invalidUsers != [ ] then
      throw "Invalid users provided to mkNixosSystem: [ ${lib.concatStringsSep ", " invalidUsers} ] (possible values: [ ${lib.concatStringsSep ", " validUsernames} ])"
    else
      lib.nixosSystem {
        modules = modules ++ [
          inputs.home-manager.nixosModules.home-manager
          {
            networking.hostName = hostname;

            services.xserver.xkb.layout = keymap;
            console.useXkbConfig = true;
            environment.variables."XKB_DEFAULT_LAYOUT" = keymap;

            home-manager.users = lib.genAttrs enableUsers (name: userProfiles.${name}.home);
            users.users = lib.foldl' (
              acc: name: lib.recursiveUpdate acc (userProfiles.${name}.system.users.users or { })
            ) { } enableUsers;
          }
        ];
      };
in
{
  inherit mkNixosSystem;
}
