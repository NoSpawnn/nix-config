{ pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/flatpak.nix
  ];

  services.flatpak.packages = [
    {
      appId = "com.bitwarden.desktop";
      origin = "flathub-user";
    }
    {
      appId = "com.orcaslicer.OrcaSlicer";
      origin = "flathub-user";
    }
    {
      appId = "com.rtosta.zapzap";
      origin = "flathub-user";
    }
    {
      appId = "dev.vencord.Vesktop";
      origin = "flathub-user";
    }
    {
      appId = "md.obsidian.Obsidian";
      origin = "flathub-user";
    }
    {
      appId = "org.onlyoffice.desktopeditors";
      origin = "flathub-user";
    }
    {
      appId = "org.signal.Signal";
      origin = "flathub-user";
    }
  ];

  home.username = "N";
  home.homeDirectory = "/home/N";
  home.packages = with pkgs; [
    quickemu
    godot
    obs-studio
  ];

  home.sessionVariables = {
    "EDITOR" = "nvim";
  };

  home.stateVersion = "25.11";
}
