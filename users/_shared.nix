{
  system = { ... }: { };

  home = { ... }: {
    home.sessionVariables."EDITOR" = "nvim";

    programs.home-manager.enable = true;
    home.stateVersion = "25.11";
  };
}
