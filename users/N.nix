{ self, ... }: {
  system = {
    users.users.N = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "dialout"
        "networkmanager"
      ];
    };
  };

  home = {
    imports = with self.homeModules; [
      flatpak
    ];

    home.username = "N";
    home.homeDirectory = "/home/N";
    home.sessionVariables."EDITOR" = "nvim";
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

    home.stateVersion = "25.11";
  };
}
