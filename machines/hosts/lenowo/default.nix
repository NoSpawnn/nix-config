{
  pkgs,
  ...
}:

{
  imports = [
    ../../profiles/laptop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "lenowo";

  services.tailscale.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot.enable = true;
    };
  };

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}
