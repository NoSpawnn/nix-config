{ ... }:

{
  imports = [
    ./base.nix

    ../modules/gui/niri.nix
    ../modules/gaming.nix
    ../modules/development.nix
  ];

  # Enable audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Other package formats
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
