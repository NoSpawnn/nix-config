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
  config = lib.mkIf cfg.enable { services.tailscale.enable = cfg.enable; };
}
