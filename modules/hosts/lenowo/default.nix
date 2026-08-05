{ self, inputs, ... }: {
  flake.nixosConfigurations.lenowo = inputs.nixpkgs.lib.nixosSystem {
    modules =
      with self.nixosModules;
      [
        userN
        laptop
        ({ ... }: { networking.hostName = "lenowo"; })
      ]
      ++ [ ./_hardware-configuration.nix ];
  };
}
