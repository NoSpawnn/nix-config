{
  moduleWithSystem,
  mylib,
  dotfiles,
  ...
}:
{
  flake.nixosModules.wpaperd = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.wpaperd ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.wpaperd = mylib.wrapProgram pkgs.wpaperd {
      inherit pkgs;
      flags."--config" = "${dotfiles}/dots/dot-config/wpaperd/config.toml";
      chdir = "${dotfiles}/dots/dot-config/wpaperd"; # cd here so that the config file can use relative paths
    };
  };
}
