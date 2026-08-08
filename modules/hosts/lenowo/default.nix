{ self, utils, ... }: {
  flake.nixosConfigurations.lenowo = utils.mkNixosSystem {
    hostname = "lenowo";
    keymap = "gb";
    modules = [
      self.nixosModules.userN
      self.nixosModules.laptop
      ./_hardware-configuration.nix
    ];
  };
}
