{ inputs, moduleWithSystem, ... }:

{
  flake.nixosModules.nemo = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.nemo ]; }
  );

  perSystem = { pkgs, ... }: {
    packages.nemo = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.nemo;

      env."GTK_ICON_THEME" = "Papirus";
      env."XDG_ICON_THEME" = "Papirus";
      prefixVar = [
        [
          "XDG_DATA_DIRS"
          ":"
          "${pkgs.papirus-icon-theme}/share"
        ]
      ];
    };
  };
}
