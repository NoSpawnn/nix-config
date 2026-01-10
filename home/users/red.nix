{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../modules/wayland.nix
  ];

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

  # idk if we actually care about resetting the path but whatever
  home.activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
    _path="$PATH"

    PATH="${pkgs.chezmoi}/bin:$PATH"
    run chezmoi init git.nospawnn.com/red/dotfiles
    run chezmoi update -a

    PATH="$_path"
  '';

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
