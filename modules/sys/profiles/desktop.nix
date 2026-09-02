{ self, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = with self.nixosModules; [
      sysCore

      niri
      flatpak
      appimage

      zsh
      development
    ];

    services.udisks2.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = [ pkgs.corefonts ];
  };
}
