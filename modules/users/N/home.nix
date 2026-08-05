{ self, ... }: {

  flake.nixosModules.userN = { ... }: {
    home-manager.users.N = self.homeModules.userN;
    users.users.N = {
      isNormalUser = true;
      ignoreShellProgramCheck = true;
      extraGroups = [
        "networkmanager"
        "dialout"
        "wheel"
        "docker"
      ];
    };
  };

  flake.homeModules.userN = { pkgs, ... }: {
    imports = with self.homeModules; [
      hmCore
      flatpak
    ];

    home.username = "N";
    home.homeDirectory = "/home/N";

    # TODO: move these to their own modules (dev, cli, etc)
    home.packages = with pkgs; [
      just
      eza
      fastfetch
      starship
      tealdeer
      zoxide
      quickemu
      obs-studio
      btop
    ];

    home.sessionVariables = {
      "EDITOR" = "nvim";
    };

    home.stateVersion = "25.11";

    services.flatpak.packages = [
      "com.bitwarden.desktop"
      "com.orcaslicer.OrcaSlicer"
      "com.rtosta.zapzap"
      "dev.vencord.Vesktop"
      "org.signal.Signal"
      "org.mozilla.Thunderbird"
      "org.godotengine.Godot"
      "md.obsidian.Obsidian"
    ];
  };
}
