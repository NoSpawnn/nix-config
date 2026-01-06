{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        spawnpoint = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/spawnpoint
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users.${user} = import ./users/${user}/home.nix;
            # }
          ];
        };
      };
    };
}
