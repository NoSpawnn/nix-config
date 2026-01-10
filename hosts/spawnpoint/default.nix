{
  pkgs,
  ...
}:

{
  networking.hostName = "spawnpoint";

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot.enable = true;
  };

  imports = [
    ../../modules/system.nix
    ../../modules/gaming.nix
    ../../modules/niri.nix
    ../../modules/development.nix

    ./hardware-configuration.nix
  ];

  modules.gaming.vr.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.red = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hardware.bluetooth.enable = true;

  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}
