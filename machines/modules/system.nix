{
  pkgs,
  ...
}:

{
  imports = [
    ./nixos.nix
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  networking.networkmanager.enable = true;

  # TODO: move these someplace better
  environment.systemPackages = with pkgs; [
    vim
    git
    fzf
    zip
    unzip
    polkit
    nps
    tree
    ripgrep
    fd
    ethtool
  ];
}
