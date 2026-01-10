{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../profiles/laptop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "lenowo";

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot.enable = true;
    };
  };

  users.users.red = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}
