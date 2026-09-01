{ moduleWithSystem, lib, ... }: {
  flake.homeModules.hmCore = moduleWithSystem (
    { self', ... }: {
      programs.home-manager.enable = true;

      # TODO: enable only if the system udiskie2 service is enabled
      services.udiskie = {
        enable = true;
        settings = {
          program_options = {
            file_manager = lib.getExe self'.packages.nemo;
          };
        };
      };
    }
  );
}
