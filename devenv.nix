{ pkgs, ... }:

{
  packages = with pkgs; [
    nil
    nixd
    nixfmt
    kdePackages.qtdeclarative # mainly for qmlformat
  ];
}
