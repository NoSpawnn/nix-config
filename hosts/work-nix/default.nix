{
  pkgs,
  ...
}:

{
  imports = [
    ../../profiles/headless.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "work-nix";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot.enable = true;
    };
  };

  services.openssh.enable = true;

  users.users = {
    J = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  hardware.bluetooth.enable = true;
  virtualisation.hypervGuest.enable = true;

  system.stateVersion = "25.11";
}
