{
  description = "My very epic NixOS config(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";

    #nix-flatpak.url = "github:gmodena/nix-flatpak/latest"; # main
    #nix-flatpak.url = "path:/home/N/Documents/nix-flatpak"; # dev
    nix-flatpak.url = "github:NoSpawnn/nix-flatpak"; # temp fork for `defaultRemote` opt

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    niri-scratchpad.url = "github:gvolpe/niri-scratchpad";
    niri-scratchpad.inputs.nixpkgs.follows = "nixpkgs";

    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    # zen-browser.inputs.home-manager.follows = "home-manager";
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

      userPresets = {
        # Regular user
        N = {
          home = import ./users/accounts/N/home.nix;
          system = import ./users/accounts/N/system.nix;
        };
        # Work user
        J = {
          home = import ./users/accounts/J/home.nix;
          system = import ./users/accounts/J/system.nix;
        };
      };

      mkNixosSystem =
        {
          users ? { },
          baseModules ? [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
            }
          ],
          extraModules ? [ ],
          system ? "x86_64-linux",
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs.flake-inputs = inputs;
          modules =
            baseModules
            ++ extraModules
            ++ [
              {
                users.users = builtins.mapAttrs (_: u: u.system) users;
                home-manager.users = builtins.mapAttrs (_: u: u.home) users;
              }
            ];
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
          users = { inherit (userPresets) N; };
          extraModules = [
            ./machines/hosts/spawnpoint
          ];
        };

        lenowo = mkNixosSystem {
          users = { inherit (userPresets) N; };
          extraModules = [
            ./machines/hosts/lenowo
          ];
        };

        work-nix = mkNixosSystem {
          users = { inherit (userPresets) J; };
          extraModules = [
            ./machines/hosts/work-nix
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
