# regular user

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
    zed-editor
    quickemu

    # tui
    lazygit
    yazi
    zellij

    # tools
    fastfetch
    tealdeer

    orca-slicer
    vesktop
    obs-studio
  ];

  home.sessionVariables = {
    "EDITOR" = "zeditor --wait";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
