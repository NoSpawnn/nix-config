{ self, utils, ... }@inputs:
let
  wanIface = "enp1s0f0";
  lanIface = "enp1s0f3";

  lanGatewayAddress = "10.10.10.1";
  dhcpRange = { start = "10.10.10.2"; end = "10.10.10.254"; };

  netConfig = { ... }: {
        networking = {
          domain = ".internal";

          firewall = {
            enable = true;
            trustedInterfaces = [ "tailscale0" ];
            allowedTCPPorts = [ 22 80 443 ];
            allowedUDPPorts = [ 53 67 68 ];
          };

          nat = {
            enable = true;
            externalInterface = wanIface;
            internalInterfaces = [ lanIface ];
          };

          interfaces = {
            "${wanIface}".useDHCP = true;
            "${lanIface}".ipv4.addresses = [
              { address = lanGatewayAddress; prefixLength = 24; }
            ];
          };

          useHostResolvConf = false;
        };
      };
in
{
  flake.nixosConfigurations.firewall = utils.mkNixosSystem {
    hostname = "firewall";
    keymap = "us";
    modules = [
      netConfig
      ./_hardware-configuration.nix
    ];
  };
}
