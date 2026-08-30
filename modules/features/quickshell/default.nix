{
  inputs,
  dotfiles,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.quickshell = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.quickshell ]; }
  );

  perSystem = { pkgs, ... }: {
    packages.quickshell = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.quickshell;
      flags."--path" = "${dotfiles}/dots/dot-config/quickshell";
    };
  };
}
