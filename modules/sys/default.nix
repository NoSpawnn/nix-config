{ self, ... }: {
  flake.nixosModules.sysCore = { ... }: {
    imports = with self.nixosModules; [
      nix
      locale
      bootloader
      networking
    ];

    # TODO: put these in their own modules
    services.openssh.enable = true;
    hardware.bluetooth.enable = true;

    programs.nix-ld.enable = true;
  };
}
