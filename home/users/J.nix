# work user

{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
  ];

  home.username = "J";
  home.homeDirectory = "/home/J";
  home.packages = with pkgs; [
    starship
    rustup
    eza
    zoxide
    direnv
    lazygit
    tealdeer
    neovim
  ];

  home.sessionVariables = {
    "EDITOR" = "nvim";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
