{ self, utils, ... }: {
  flake.nixosConfigurations.nas = utils.mkNixosSystem {
    hostname = "nas";
    keymap = "us";
    modules = [

      ./_hardware-configuration.nix
    ];
  };
}

