{
  inputs,
  ...
}:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  config._module.args = {
    dotfiles = inputs.dotfiles;
  };

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
