{
  lib,
  pkgs,
  user,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";
  # why doesnt this work?
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "en_GB.UTF-8";
  #   LC_IDENTIFICATION = "en_GB.UTF-8";
  #   LC_MEASUREMENT = "en_GB.UTF-8";
  #   LC_MONETARY = "en_GB.UTF-8";
  #   LC_NAME = "en_GB.UTF-8";
  #   LC_NUMERIC = "en_GB.UTF-8";
  #   LC_PAPER = "en_GB.UTF-8";
  #   LC_TELEPHONE = "en_GB.UTF-8";
  #   LC_TIME = "en_GB.UTF-8";
  # };

  networking.networkmanager.enable = true;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    vim
    git
    fzf
    tealdeer
    corefonts # ms-corefonts
    zip
    unzip
    polkit
    corectrl
    nps
    tree
  ];

  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
