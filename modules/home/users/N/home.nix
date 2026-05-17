{ pkgs, ... }:
{
  imports = [
    ../../modules/wayland.nix
  ];

  home.username = "N";
  home.homeDirectory = "/home/N";
  home.packages = with pkgs; [
    # shell
    starship
    eza
    zoxide

    # dev
    neovim
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
    "EDITOR" = "nvim";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
