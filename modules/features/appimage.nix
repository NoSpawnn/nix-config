{ ... }: {
  flake.nixosModules.appimage = { config, lib, ... }: {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # if nix-flatpak is enabled, install gearlever
    services.flatpak = lib.mkIf (builtins.hasAttr "packages" config.services.flatpak) {
      packages = [ "it.mijorus.gearlever" ];
    };
  };
}
