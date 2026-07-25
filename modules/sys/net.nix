{ ... }:
{
  flake.nixosModules.networking = { ... }: {
      services.tailscale.enable = true;
      networking.networkmanager.enable = true;
  };
}
