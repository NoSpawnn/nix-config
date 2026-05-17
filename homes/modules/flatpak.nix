{ flake-inputs, ... }:

{
  imports = [ flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub-user";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };
}
