{
  description = "My very epic NixOS config(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-scratchpad = {
      url = "github:gvolpe/niri-scratchpad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        spawnpoint =
          let
            users = [ "N" ];
            inherit (nixpkgs) lib;
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/spawnpoint
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users = lib.genAttrs users (user: import ./home/users/${user}.nix);
              }
            ];
          };

        lenowo =
          let
            users = [
              "N"
              "J"
            ];
            inherit (nixpkgs) lib;
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/lenowo
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users = lib.genAttrs users (user: import ./home/users/${user}.nix);
              }
            ];
          };
      };
    };
}
