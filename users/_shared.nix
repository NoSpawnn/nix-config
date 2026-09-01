{
  system = { ... }: { };

  home = { ... }: {
    home.sessionVariables."EDITOR" = "nvim";

    services.udiskie = {
      enable = true;
      settings.program_options.file_manager = "nemo";
    };

    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
  };
}
