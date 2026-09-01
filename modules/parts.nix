{ inputs, self, ... }: {
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  config._module.args = {
    dotfiles = inputs.dotfiles;
    utils = import ./_utils.nix {
      lib = inputs.nixpkgs.lib;
      userProfiles = self.userProfiles;
    };
  };

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
