{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.modules.chezmoi;
in
{
  options.modules.chezmoi = {
    dotfilesDir = lib.mkOption {
      type = lib.types.path;
      default = "${config.home.homeDirectory}/.dotfiles";
      description = "directory for chezmoi to pull into. should match sourceDir in chezmoi config";
    };
    dotfilesRepoUrl = lib.mkOption {
      type = lib.types.str;
      description = "git repository for chezmoi to pull from";
    };
    forceApply = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "chezmoi force apply";
    };
  };

  config = {
    home.packages = [ pkgs.chezmoi ];

    # refs:
    #   https://git.sapphiccode.net/SapphicCode/universe/src/commit/390460d420eb2e0b9f345a656857581baa15ead4/home-manager/profile/minimal.nix#L16
    #   https://github.com/budimanjojo/nix-config/blob/427b7fb56990fbbd56507aeafbec55835814e719/home/_modules/programs/chezmoi/default.nix#L18
    home.activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
      [[ -d "${cfg.dotfilesDir}" ]] && exit 0 # only run on first init

      chezmoi="${pkgs.chezmoi}/bin/chezmoi"

      mkdir -p "${cfg.dotfilesDir}"
      run $chezmoi init "${cfg.dotfilesRepoUrl}" -S "${cfg.dotfilesDir}"
      run $chezmoi apply --mode symlink ${if cfg.forceApply then "--force" else ""} 
    '';
  };
}
