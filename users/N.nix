# meeeee
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
  } // ((import ./_shared.nix).system {});

  home = {
    imports = with self.homeModules; [ flatpak ];

    services.udiskie = {
      enable = true;
      settings.program_options.file_manager = "nemo";
    };

    home.username = "N";
    home.homeDirectory = "/home/N";
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
  } // ((import ./_shared.nix).home {});
}
