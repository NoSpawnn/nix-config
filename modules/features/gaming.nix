{ inputs, ... }:
let
  nix-gaming = inputs.nix-gaming;
in
{
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = [
      nix-gaming.nixosModules.pipewireLowLatency
      nix-gaming.nixosModules.platformOptimizations
    ];

    programs.gamescope = {
      # https://github.com/ValveSoftware/gamescope/issues/1622
      enable = true;
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      });
    };

    services.pipewire.lowLatency.enable = true;
    programs.gamemode.enable = true;
    environment.systemPackages = [ pkgs.protonup-qt ];
    programs.steam = {
      enable = true;
      platformOptimizations.enable = true;
      extraPackages = [ pkgs.mangohud ];
    };

    # i should play VR more...
    services.wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
    };
  };
}
