{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.userProfiles =
    let
      userFiles = builtins.readDir ../users;
      validFiles = lib.filterAttrs (name: _: !(lib.hasPrefix "_" name)) userFiles;
    in
    lib.mapAttrs' (
      filename: _:
      let
        name = lib.removeSuffix ".nix" filename;
      in
      lib.nameValuePair name (import (../users + "/${filename}") { inherit inputs self; })
    ) validFiles;
}
