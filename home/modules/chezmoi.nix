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
    dotfilesRepoUrl = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    home.packages = [ pkgs.chezmoi ];

    # idk if we actually care about resetting the path but whatever
    # https://git.sapphiccode.net/SapphicCode/universe/src/commit/390460d420eb2e0b9f345a656857581baa15ead4/home-manager/profile/minimal.nix#L16
    # https://github.com/budimanjojo/nix-config/blob/427b7fb56990fbbd56507aeafbec55835814e719/home/_modules/programs/chezmoi/default.nix#L18
    home.activation.chezmoi = lib.hm.dag.entryAfter [ "installPackages" ] ''
      _path="$PATH"
      PATH="${pkgs.chezmoi}/bin:$PATH"

      # we only want to run this on first install
      if [[ ! -d "$(chezmoi source-path)" ]]; then
        run chezmoi init ${cfg.dotfilesRepoUrl}
        run chezmoi apply --force
      fi

      PATH="$_path"
    '';
  };
}
