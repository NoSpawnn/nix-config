{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.development;
in
{
  config = {
      virtualisation.docker.enable = true;
      virtualisation.podman.enable = true;
      networking.nftables.enable = true;
      virtualisation.incus.enable = true;
      environment.systemPackages = [ pkgs.aardvark-dns ];
      networking.firewall.interfaces.incusbr0.allowedTCPPorts = [ 53 67 ];
      networking.firewall.interfaces.incusbr0.allowedUDPPorts = [ 53 67 ];
  };
}
