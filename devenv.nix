{ pkgs, ... }:

{
  packages = with pkgs; [
    nil
    nixd
    nixfmt
    kdePackages.qtdeclarative # mainly for qmlformat
  ];

  scripts = {
    "nrs".exec = "sudo nixos-rebuild switch --flake";
    "nfu".exec = "nix flake update";
  };
}
