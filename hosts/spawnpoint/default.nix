{
  pkgs,
  ...
}:

{
  imports = [
    ../../profiles/pc.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "spawnpoint";

  networking.interfaces."enp11s0".wakeOnLan.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = true;
    };
  };

  modules = {
    tailscale.enable = true;
    gaming = {
      enable = true;
      vr.enable = true;
    };
  };

  users.users.N = {
    isNormalUser = true;
    description = "I love doing anything!";
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
