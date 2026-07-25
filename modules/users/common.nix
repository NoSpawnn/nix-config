{ ... }:
{
  flake.homeModules.hmCore = { pkgs, ... }: {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
    ];
  };
}
