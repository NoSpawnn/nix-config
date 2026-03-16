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
  options.modules.development = {
    godot.enable = lib.mkEnableOption "Godot engine";
  };

  config = lib.mkMerge [
    { virtualisation.podman.enable = true; }
    (lib.mkIf cfg.godot.enable { environment.systemPackages = [ pkgs.godot ]; })
  ];
}
