{ moduleWithSystem, ... }:

{
  flake.nixosModules.nemo = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.nemo ]; }
  );

  perSystem = { pkgs, ... }: { packages.nemo = pkgs.nemo; };

}
