{ pkgs, ... }:

{
  imports = [
    ./pc.nix
  ];

  # Enable touchpad
  services.libinput.enable = true;

  environment.systemPackages = [ pkgs.brightnessctl ];
}
