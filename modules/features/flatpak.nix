{ inputs, ... }:
let
  flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
in
{
  flake.nixosModules.flatpak = { ... }: {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      remotes = [
        {
          name = "flathub";
          location = flathub;
        }
      ];
      packages = [
        "com.github.tchx84.Flatseal"
        "app.zen_browser.zen"
      ];
    };
  };

  flake.homeModules.flatpak = { ... }: {
    imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

    services.flatpak = {
      defaultOrigin = "flathub-user";
      uninstallUnmanaged = true;
      remotes = [
        {
          name = "flathub-user";
          location = flathub;
        }
      ];
    };
  };
}
