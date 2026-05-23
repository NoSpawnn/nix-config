{ pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/flatpak.nix
  ];

  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.orcaslicer.OrcaSlicer"
    "com.rtosta.zapzap"
    "dev.vencord.Vesktop"
    "org.signal.Signal"
    "org.mozilla.Thunderbird"
    "org.godotengine.Godot"
  ];

  home.username = "N";
  home.homeDirectory = "/home/N";
  home.packages = with pkgs; [
    quickemu
    obs-studio
    btop
  ];

  home.sessionVariables = {
    "EDITOR" = "nvim";
  };

  home.stateVersion = "25.11";
}
