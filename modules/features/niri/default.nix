{
  moduleWithSystem,
  inputs,
  dotfiles,
  self,
  ...
}:

{
  perSystem =
    { system, pkgs, ... }:
    {
      packages.niri = inputs.wrappers.wrappers.niri.wrap {
        config = {
          inherit pkgs;

          "config.kdl".content = builtins.readFile "${dotfiles}/dots/dot-config/niri/config.kdl";

          runtimePkgs =
            with pkgs;
            [
              brightnessctl
              gnome-keyring
              polkit
              polkit_gnome
              swayidle
              swaylock
              wlsunset
              xdg-desktop-portal
              xdg-desktop-portal-gnome
              xdg-desktop-portal-gtk
              xwayland-satellite
            ]
            ++ [
              inputs.noctalia.packages.${system}.default
              inputs.niri-scratchpad.packages.${system}.default
            ];
        };
      };
    };

  flake.nixosModules.niri = moduleWithSystem (
    { self', pkgs, ... }:
    {
      imports = with self.nixosModules; [
        ly
        kitty
        otter-launcher
        nemo
        wpaperd
      ];

      programs.niri = {
        enable = true;
        package = self'.packages.niri;
      };

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];

      environment.sessionVariables = {
        "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
        "MOZ_WEBRENDER" = "1";
        "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
        "QT_QPA_PLATFORM" = "wayland";
        "SDL_VIDEODRIVER" = "wayland";
        "GDK_BACKEND" = "wayland";
        "XDG_SESSION_TYPE" = "wayland";
      };

      security.polkit.enable = true;
      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    }
  );
}
