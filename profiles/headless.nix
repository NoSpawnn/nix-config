{ pkgs, flake-inputs, ... }:

{
  imports = [
    ./base.nix

    ../modules/development.nix
  ];

  # Other package formats
  programs.nix-ld.enable = true;
}
