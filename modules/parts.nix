{
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  config._module.args = {
    dotfiles = inputs.dotfiles;
    mylib = import ./_mylib.nix { inherit lib; };
  };

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
