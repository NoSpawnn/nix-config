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
    neovim
    lua-language-server
    zed-editor
    nixd
    nil
    rustup
    direnv
    quickemu
    godot
    typst
    tinymist

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
    jan
  ];

  home.sessionVariables = {
    "EDITOR" = "zeditor --wait";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
