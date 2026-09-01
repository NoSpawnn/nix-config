{ self, utils, ... }: {
  flake.nixosConfigurations.spawnpoint = utils.mkNixosSystem {
    hostname = "spawnpoint";
    keymap = "us";
    enableUsers = [ "N" ];
    modules = with self.nixosModules; [
      desktop
      gaming
      amdDrivers
      ./_hardware-configuration.nix
    ];
  };
}
