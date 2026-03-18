{
  lib,
  config,
  ...
}:

let
  cfg = config.modules.tailscale;
in
{
  options.modules.tailscale.enable = lib.mkEnableOption "Tailscale";
  config = { services.tailscale.enable = cfg.enable; };
}
