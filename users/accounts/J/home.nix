{
  ...
}:

{
  home.username = "J";
  home.homeDirectory = "/home/J";

  imports = [
    ../../modules/common.nix
  ];

  home.sessionVariables = {
    "EDITOR" = "nvim";
  };

  home.stateVersion = "25.11";
}
