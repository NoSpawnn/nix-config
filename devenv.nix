{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    git
    nil
    nixd
    nixfmt
  ];
}
