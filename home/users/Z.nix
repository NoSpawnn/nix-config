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

  home.username = "Z";
  home.homeDirectory = "/home/Z";
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
