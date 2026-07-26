{
  moduleWithSystem,
  ...
}:

{
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
        environment.systemPackages = [ self'.packages.kitty ];
    }
  );

  perSystem = { pkgs, ... }: { packages.kitty = pkgs.kitty; };
}
