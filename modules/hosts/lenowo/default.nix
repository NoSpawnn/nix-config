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

  modules.tailscale.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot.enable = true;
    };
  };

  # users.users = {
  #   N = {
  #     isNormalUser = true;
  #     extraGroups = [
  #       "networkmanager"
  #       "wheel"
  #       "docker"
  #     ];
  #   };
  # };

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}
