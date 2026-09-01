{ utils, ... }: {
  flake.nixosConfigurations.nas = utils.mkNixosSystem {
    hostname = "nas";
    keymap = "us";
    enableUsers = [ "cyn" ];
    modules = [ ./_hardware-configuration.nix ];
  };
}
