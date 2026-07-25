{ inputs, self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    let
      extraPkgs = with inputs; {
        noctalia-shell = noctalia.packages.${pkgs.system}.default;
        niri-scratchpad = niri-scratchpad.packages.${pkgs.system}.niri-scratchpad;
      };
    in
    {
      imports = [ self.nixosModules.ly ];

      programs.niri.enable = true;
      environment.systemPackages =
        with pkgs;
        [
          # core for niri
          ghostty
          fuzzel
          nautilus
          # TODO: switch to kde portals or something else
          xdg-desktop-portal
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
          gnome-keyring
          polkit
          polkit_gnome
          xwayland-satellite
          swaybg
          swaylock

          # additional stuff
          quickshell
          wlsunset
          brightnessctl
          gpu-screen-recorder
          pavucontrol
          wl-clipboard
        ]
        ++ (builtins.attrValues extraPkgs);

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
    };
}
