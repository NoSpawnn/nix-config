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
  # https://git.sapphiccode.net/SapphicCode/universe/src/commit/390460d420eb2e0b9f345a656857581baa15ead4/home-manager/profile/minimal.nix#L16
  # https://github.com/budimanjojo/nix-config/blob/427b7fb56990fbbd56507aeafbec55835814e719/home/_modules/programs/chezmoi/default.nix#L18
  home.activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
    # we only want to run this on first install
    [[ -d "$(chezmoi source-path)" ]] && exit 0

    _path="$PATH"

    PATH="${pkgs.chezmoi}/bin:$PATH"
    run chezmoi init git.nospawnn.com/red/dotfiles
    run chezmoi update -a

    PATH="$_path"
  '';

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
