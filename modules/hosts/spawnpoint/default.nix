{ self, inputs, ... }:
{
  flake.nixosConfigurations.spawnpoint = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      amdDrivers
      desktop
      gaming
      # spawnpoint-hardware

      ({ ... }: {
        networking.hostName = "spawnpoint";
        networking.interfaces."enp11s0".wakeOnLan.enable = true;

        home-manager.users.N = self.homeModules.userN;
        users.users.N = {
          isNormalUser = true;
          extraGroups = [
            "networkmanager"
            "dialout"
            "wheel"
            "docker"
          ];
        };
      })
    ] ++ [ ./_hardware-configuration.nix ];
  };
}
