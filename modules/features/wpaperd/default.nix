{
  moduleWithSystem,
  dotfiles,
  inputs,
  ...
}:
{
  flake.nixosModules.wpaperd = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.wpaperd ];
    }
  );

  perSystem =
    { pkgs, ... }:
    let
      config = builtins.toFile "config.toml" ''
        [any]
        path = "${dotfiles}/wallpapers/rainy-moon.png"
      '';
    in
    {
      packages.wpaperd = inputs.wrappers.lib.wrapPackage (
        { ... }: {
          inherit pkgs;
          package = pkgs.wpaperd;
          flags."--config" = config;
        }
      );
    };
}
