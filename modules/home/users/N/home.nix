{ pkgs, flake-inputs, ... }:

{
  imports = [
    ../../modules/wayland.nix
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub-user";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.bitwarden.desktop"
      "com.rtosta.zapzap"
      "md.obsidian.Obsidian"
      "org.onlyoffice.desktopeditors"
      "org.signal.Signal"
    ];
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
