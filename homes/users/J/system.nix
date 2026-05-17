{ ... }:
{
  isNormalUser = true;
  extraGroups = [
    "networkmanager"
    "wheel"
    "docker"
  ];
}
