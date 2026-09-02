{ self, utils, ... }: {
  flake.nixosConfigurations.lenowo = utils.mkNixosSystem {
    hostname = "lenowo";
    keymap = "gb";
    enableUsers = [ "N" ];
    modules = [
      self.nixosModules.laptop
      ./_hardware-configuration.nix
    ];
  };
}
