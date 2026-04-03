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
  };
}
