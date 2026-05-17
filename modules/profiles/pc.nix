{ pkgs, flake-inputs, ... }:

{
  imports = [
    ./base.nix

    ../modules/gui/niri.nix
    ../modules/gaming.nix
    ../modules/development.nix

    flake-inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # Enable audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tor-browser
    blueman
    corefonts # ms-corefonts
  ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    remotes = [
      # TODO: pr to nix-flatpak to allow changing the default origin, as this one MUST be named flathub, else you want to define `origin` for every package
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.github.tchx84.Flatseal"
      "app.zen_browser.zen"
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
}
