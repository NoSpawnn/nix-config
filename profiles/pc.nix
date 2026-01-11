{ pkgs, flake-inputs, ... }:

let
  zen-browser = flake-inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
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

  environment.systemPackages = [ zen-browser ];

  # Other package formats
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
