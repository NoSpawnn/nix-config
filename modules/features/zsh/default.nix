{ moduleWithSystem, ... }:
{
  flake.nixosModules.zsh = moduleWithSystem ({ ... }: {
      programs.zsh = {
          enable = true;
          interactiveShellInit = "source ${./zshrc}";
      };
  });

  flake.homeModules.zsh = { config, pkgs, ... }: {
      programs.zsh = {
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          initContent = "source ${./zshrc}";
          autosuggestion.enable = true;
      };
  };

  perSystem = { self', ... }: { packages.zsh = self'.packages.zsh; };
}
