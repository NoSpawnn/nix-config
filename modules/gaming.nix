{
  flake-inputs,
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming;
  nix-gaming = flake-inputs.nix-gaming;
in
{
  imports = [
    nix-gaming.nixosModules.pipewireLowLatency
    nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.gaming = {
    enable = lib.mkEnableOption "Gaming";
    vr.enable = lib.mkEnableOption "VR Support (WiVRn)";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      # general gaming stuff
      {
        programs.gamescope = {
          # https://github.com/ValveSoftware/gamescope/issues/1622
          enable = true;
          package = pkgs.gamescope.overrideAttrs (_: {
            NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
          });
        };
        services.pipewire.lowLatency.enable = true;
        programs.gamemode.enable = true;
        programs.steam = {
          enable = true;
          platformOptimizations.enable = true;
          extraPackages = [ pkgs.mangohud ];
        };
      }

      # VR gaming
      # https://wiki.nixos.org/wiki/VR
      (lib.mkIf cfg.vr.enable {
        services.wivrn = {
          enable = true;
          openFirewall = true;
          defaultRuntime = true;
          autoStart = true;
        };
      })
    ]
  );
}
