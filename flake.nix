{
  description = "My very epic NixOS config(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";

    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    niri-scratchpad.url = "github:gvolpe/niri-scratchpad";
    niri-scratchpad.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;

      mkNixosSystem =
        {
          users ? { },
          baseModules ? [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
              home-manager.users = users;
            }
          ],
          extraModules ? [ ],
          system ? "x86_64-linux",
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs.flake-inputs = inputs;
          modules = baseModules ++ extraModules;
        };

      forEachSupportedSystem =
        f:
        lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "aarch64-darwin"
          ]
          (
            system:
            f {
              inherit system;
              pkgs = import nixpkgs { inherit system; };
            }
          );
    in
    {
      nixosConfigurations = {
        spawnpoint = mkNixosSystem {
          users.N = import ./home/users/N.nix;
          extraModules = [
            ./hosts/spawnpoint
          ];
        };

        lenowo = mkNixosSystem {
          users.N = import ./home/users/N.nix;
          extraModules = [
            ./hosts/lenowo
          ];
        };

        work-nix = mkNixosSystem {
          users.J = import ./home/users/J.nix;
          extraModules = [
            ./hosts/work-nix
          ];
        };
      };

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nil
              nixd
              self.formatter.${system}
            ];
          };
        }
      );
    };
}
