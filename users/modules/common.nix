{ pkgs, ... }:

{
  # I manage all my configs outside of nix, so don't use programs.*
  home.packages = with pkgs; [
    tmux
    lazygit
    direnv
    eza
    fastfetch
    starship
    tealdeer
    zoxide
    neovim
  ];

  programs.home-manager.enable = true;
}
