# work user

{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
    ../modules/chezmoi.nix
  ];

  modules.chezmoi = {
    dotfilesRepoUrl = "https://git.nospawnn.com/red/dotfiles";
    forceApply = true;
  };

  home.username = "J";
  home.homeDirectory = "/home/J";
  home.packages = with pkgs; [
    starship
    rustup
    eza
    zoxide
    direnv
    lazygit
    yazi
    helix
    tealdeer
    zellij
  ];

  home.sessionVariables = {
    "EDITOR" = "hx";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
