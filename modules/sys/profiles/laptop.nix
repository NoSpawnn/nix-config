{ self, ... }: {
  flake.nixosModules.laptop = { pkgs, ... }: {
    imports = [ self.nixosModules.desktop ];
    services.libinput.enable = true;
    environment.systemPackages = [ pkgs.brightnessctl ];
    services.upower.enable = true;
  };
}
