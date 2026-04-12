{
  pkgs,
  ...
}:

{
  imports = [ ./ly.nix ];

  services = {
    desktopManager.cosmic.enable = true;
  };

  environment.systemPackages = [ pkgs.kdePackages.yakuake ];
  environment.cosmic.excludePackages = with pkgs; [ ];
}
