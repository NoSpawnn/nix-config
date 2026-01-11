{
  pkgs,
  ...
}:

{
  imports = [
    ./tailscale.nix  
  ];
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    fzf
    corefonts # ms-corefonts
    zip
    unzip
    polkit
    nps
    tree
    ripgrep
    ethtool
  ];
}
