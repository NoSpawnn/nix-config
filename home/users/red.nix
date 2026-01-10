{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
  ];

  home.username = "red";
  home.homeDirectory = "/home/red";
  home.packages = with pkgs; [
    starship
    rustup
    eza
    zoxide
    direnv
    orca-slicer
    lazygit
    yazi
    stow
    fastfetch
    helix
    nixd
    nil
    tealdeer
    zellij
  ];

  home.sessionVariables = {
    "EDITOR" = "hx";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
