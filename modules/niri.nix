# currently just installation of niri and supporting packages, configuration is not handled in Nix (yet?)

{
  flake-inputs,
  pkgs,
  ...
}:

let
  extraPkgs = with flake-inputs; {
    noctalia-shell = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    niri-scratchpad = niri-scratchpad.packages.${pkgs.stdenv.hostPlatform.system}.niri-scratchpad;
  };
in
{
  imports = [ ./ly.nix ];

  programs.niri.enable = true;
  environment.systemPackages =
    with pkgs;
    [
      # core for niri
      alacritty
      fuzzel
      nautilus
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
      # quickshell # noctalia-shell installs this for us
      wlsunset
      brightnessctl
      gpu-screen-recorder
      pavucontrol

      # for config
      kdlfmt
    ]
    ++ (builtins.attrValues extraPkgs);

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
