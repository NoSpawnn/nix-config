{ self, moduleWithSystem, ... }:

{
  flake.nixosModules.mounts = moduleWithSystem (
    { ... }: {
    }
  );
}
