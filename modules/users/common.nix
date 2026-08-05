{ moduleWithSystem, ... }: {
  flake.homeModules.hmCore = moduleWithSystem ({ ... }: { programs.home-manager.enable = true; });
}
