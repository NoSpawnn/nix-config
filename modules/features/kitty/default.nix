{
  moduleWithSystem,
  dotfiles,
  inputs,
  ...
}:

{
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.kitty ];
    }
  );

  perSystem =
    { pkgs, ... }:
    let
      font = pkgs.nerd-fonts._0xproto;
    in
    {
      packages.kitty = inputs.wrappers.lib.wrapPackage (
        { ... }: {
          inherit pkgs;
          package = pkgs.kitty;
          flags."--config" = "${dotfiles}/dots/dot-config/kitty/kitty.conf";
          env."XDG_DATA_DIRS" = "${font}/share";
        }
      );
    };
}
