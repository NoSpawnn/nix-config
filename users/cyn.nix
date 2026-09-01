# sysadmin user
{ ... }: {
  system = {
    users.users.cyn = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "dialout"
        "networkmanager"
      ];
    };
  } // ((import ./_shared.nix).system {});

  home = {
    home.username = "cyn";
    home.homeDirectory = "/home/cyn";
  } // ((import ./_shared.nix).home {});
}
