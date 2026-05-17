{ ... }:
{
  isNormalUser = true;
  extraGroups = [
    "networkmanager"
    "dialout"
    "wheel"
    "docker"
  ];
}
