{
  flake-inputs,
  ...
}:

{
  imports = [ flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.enable = true;
  services.flatpak.update.auto.enable = true;
  services.flatpak.packages = [
    "com.obsproject.Studio"
  ];
}
