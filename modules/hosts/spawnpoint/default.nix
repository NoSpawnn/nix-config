{ self, inputs, ... }: {
  flake.nixosConfigurations.spawnpoint = inputs.nixpkgs.lib.nixosSystem {
    modules =
      with self.nixosModules;
      [
        userN

        amdDrivers
        desktop
        gaming

        ({ ... }: {
          networking.hostName = "spawnpoint";
          networking.interfaces."enp11s0".wakeOnLan.enable = true;
        })
      ]
      ++ [ ./_hardware-configuration.nix ];
  };
}
