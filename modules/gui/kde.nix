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
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation
    kdePackages.kpat
    kdePackages.ksudoku
    kdePackages.ktorrent
  ];
}
