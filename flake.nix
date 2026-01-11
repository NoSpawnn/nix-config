{
  description = "My very epic NixOS config(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;

      # ------------------
      # System definitions
      # ------------------

      hosts = {
        spawnpoint = {
          users = [ "N" ];
        };

        lenowo = {
          users = [
            "N"
            "J"
          ];
        };
      };

      # ---------
      # Functions
      # ---------

      mkHost =
        {
          name,
          config,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs.flake-inputs = inputs;
          modules = [
            ./hosts/${name}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
              home-manager.users = lib.genAttrs config.users (user: import ./home/users/${user}.nix);
            }
          ];
        };
    in
    {
      nixosConfigurations = lib.mapAttrs (
        systemName: systemConfig:
        mkHost {
          name = systemName;
          config = systemConfig;
        }
      ) hosts;
    };
}
