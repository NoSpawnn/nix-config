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

  perSystem = { self', pkgs, ... }: {
    packages.lazygit = inputs.wrappers.lib.wrapPackage (
      { ... }: {
        inherit pkgs;
        package = pkgs.lazygit;
        runtimePkgs = [ self'.packages.git ];
        flags."--use-config-file" = "${dotfiles}/dots/dot-config/lazygit/config.yml";
      }
    );
  };
}
