{
  moduleWithSystem,
  dotfiles,
  mylib,
  ...
}:

{
  flake.nixosModules.otter-launcher = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.otter-launcher ];
    }
  );

  perSystem = { inputs', pkgs, ... }: {
    packages.otter-launcher = mylib.wrapProgram inputs'.otter-launcher.packages.default {
      inherit pkgs;
      flags."--config" = "${dotfiles}/dots/dot-config/otter-launcher/config.toml";
    };
  };
}
