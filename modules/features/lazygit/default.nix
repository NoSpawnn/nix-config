{
  moduleWithSystem,
  dotfiles,
  inputs,
  ...
}:
{
  flake.nixosModules.lazygit = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.lazygit ]; }
  );

  perSystem = { pkgs, ... }: {
    packages.lazygit = inputs.wrappers.lib.wrapPackage (
      { ... }: {
        inherit pkgs;
        package = pkgs.lazygit;
        flags."--use-config-file" = "${dotfiles}/dots/dot-config/lazygit/config.yml";
      }
    );
  };
}
