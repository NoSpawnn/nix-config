{ self, ... }:
{
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = with self.nixosModules; [
      sysCore
      niri
      homeManager

      # app format support
      flatpak
      appimage
    ];

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [ corefonts ];
  };
}
