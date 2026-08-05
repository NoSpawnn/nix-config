{ ... }: {
  # https://codeberg.org/fairyglade/ly/src/branch/master/res/config.ini
  flake.nixosModules.ly = { ... }: {
    services.displayManager.ly = {
      enable = true;
      settings = {
        bigclock = "en";
      };
    };
  };
}
