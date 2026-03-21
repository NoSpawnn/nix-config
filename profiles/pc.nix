{ pkgs, flake-inputs, ... }:

let
  zen-browser = flake-inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    ./base.nix

    ../modules/gui/niri.nix
    ../modules/gui/kde.nix
    ../modules/gui/cosmic.nix
    ../modules/gaming.nix
    ../modules/development.nix
  ];

  # Enable audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages =
    with pkgs;
    [
      tor-browser
      blueman
    ]
    ++ [ zen-browser ];

  # Other package formats
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
}
