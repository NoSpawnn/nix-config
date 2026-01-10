{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.vrEnable = lib.mkEnableOption "VR Support (WiVRn)";

  config = lib.mkMerge [
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
    (lib.mkIf config.vrEnable {
      services.wivrn = {
        enable = true;
        openFirewall = true;
        defaultRuntime = true;
        autoStart = true;
      };
    })
  ];
}
