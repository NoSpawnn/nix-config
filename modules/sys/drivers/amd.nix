# yoink https://git.voidarc.co.uk/voidarc/nixos/src/branch/dendritic/modules/system/drivers/amd.nix
{ ... }:
{
  flake.nixosModules.amdDrivers = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      mesa
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      vulkan-tools
    ];

    services.lact.enable = true;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
          rocmPackages.clr.icd
        ];
      };
      amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
        overdrive.enable = true;
      };
    };

    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    # For rOCM
    systemd.tmpfiles.rules = [
      "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
    ];
  };
}
