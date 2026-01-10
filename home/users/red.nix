{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
    ../modules/chezmoi.nix
  ];

  modules.chezmoi.dotfilesRepoUrl = "git.nospawnn.com/red/dotfiles";

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
    chezmoi
  ];

  home.sessionVariables = {
    "EDITOR" = "hx";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
