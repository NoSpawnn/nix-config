{
  description = "My very epic NixOS config(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.inputs.flake-parts.follows = "flake-parts";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri-scratchpad.url = "github:gvolpe/niri-scratchpad";
    niri-scratchpad.inputs.nixpkgs.follows = "nixpkgs";
    niri-scratchpad.inputs.systems.follows = "systems";

    quadmanix.url = "github:NoSpawnn/quadmanix";
    quadmanix.inputs.nixpkgs.follows = "nixpkgs";

    otter-launcher.url = "github:kuokuo123/otter-launcher";
    otter-launcher.inputs.nixpkgs.follows = "nixpkgs";
    otter-launcher.inputs.flake-parts.follows = "flake-parts";
    otter-launcher.inputs.home-manager.follows = "home-manager";
    otter-launcher.inputs.systems.follows = "systems";

    self.submodules = true;
    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;

    import-tree.url = "github:denful/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    wrappers.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);
}
