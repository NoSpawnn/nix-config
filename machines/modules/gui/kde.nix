{
  pkgs,
  ...
}:

{
  imports = [ ./ly.nix ];

  services = {
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = [ pkgs.kdePackages.yakuake ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kdepim-runtime
    kmahjongg
    kmines
    konversation
    kpat
    ksudoku
    ktorrent
  ];
}
