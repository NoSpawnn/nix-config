{ self, utils, ... }: {
  flake.nixosConfigurations.hv-1 = utils.mkNixosSystem {
    hostname = "hv-1";
    keymap = "us";
    enableUsers = [ "cyn" ];
    modules = [
      ({ ... }: {
        services.logind.settings.Login.HandleLidSwitch = "ignore";

        virtualisation = {
          containers.enable = true;
          podman.enable = true;
        };

        services.nfs.idmapd.settings = {
          General = {
            Domain = "internal";
          };
          Mapping = {
            Nobody-User = "nobody";
            Nobody-Group = "nogroup";
          };
        };

        fileSystems = {
          "/mnt/nfs/appdata" = {
            device = "truenas.internal:/mnt/tank/appdata";
            fsType = "nfs";
            options = [
              "nfsvers=4.2"
              "hard"
              "noatime"
              "rw"
              "defaults"
            ];
          };
          "/mnt/nfs/gallery" = {
            device = "truenas.internal:/mnt/tank/gallery";
            fsType = "nfs";
            options = [
              "nfsvers=4.2"
              "hard"
              "noatime"
              "rw"
              "defaults"
            ];
          };
          "/mnt/nfs/git" = {
            device = "truenas.internal:/mnt/tank/git";
            fsType = "nfs";
            options = [
              "nfsvers=4.2"
              "hard"
              "noatime"
              "rw"
              "defaults"
            ];
          };
          "/mnt/nfs/media" = {
            device = "truenas.internal:/mnt/tank/media";
            fsType = "nfs";
            options = [
              "nfsvers=4.2"
              "hard"
              "noatime"
              "rw"
              "defaults"
            ];
          };
          "/mnt/nfs/vault" = {
            device = "truenas.internal:/mnt/tank/vault";
            fsType = "nfs";
            options = [
              "nfsvers=4.2"
              "hard"
              "noatime"
              "rw"
              "defaults"
            ];
          };
        };

        boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
        networking.firewall = {
          enable = true;
          allowedTCPPorts = [
            80
            443
            222
          ];
        };
      })
      ./_hardware-configuration.nix
    ];
  };
}
