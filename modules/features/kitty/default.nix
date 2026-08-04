{
  moduleWithSystem,
  dotfiles,
  mylib,
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
      packages.kitty = mylib.wrapProgram pkgs.kitty {
        inherit pkgs;
        flags."--config" = "${dotfiles}/dots/dot-config/kitty/kitty.conf";
        extraPrefix."XDG_DATA_DIRS" = "${font}/share";
      };
    };
}
