# regular user

{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
    ../modules/chezmoi.nix
    ../modules/flatpak.nix
  ];

  modules.chezmoi = {
    dotfilesRepoUrl = "git.nospawnn.com/red/dotfiles";
    forceApply = true;
  };

  home.username = "N";
  home.homeDirectory = "/home/N";
  home.packages = with pkgs; [
    # shell
    starship
    eza
    zoxide

    # dev
    nixd
    nil
    rustup
    direnv

    # tui
    lazygit
    yazi
    zellij
    helix

    # tools
    fastfetch
    tealdeer

    orca-slicer
    vesktop
  ];

  home.sessionVariables = {
    "EDITOR" = "hx";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
