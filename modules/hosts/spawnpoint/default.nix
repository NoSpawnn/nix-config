{ self, utils, ... }: {
  flake.nixosConfigurations.spawnpoint = utils.mkNixosSystem {
    hostname = "spawnpoint";
    keymap = "us";
    modules = with self.nixosModules; [
      userN
      desktop
      gaming
      amdDrivers
      ./_hardware-configuration.nix
    ];
  };
}

