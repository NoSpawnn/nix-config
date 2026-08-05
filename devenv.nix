{ pkgs, ... }:

{
  packages = with pkgs; [
    nil
    nixd
    nixfmt
  ];
}
