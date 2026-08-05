{
  inputs,
  moduleWithSystem,
  dotfiles,
  ...
}:

{
  flake.nixosModules.zsh =
    let
      flakePath = builtins.getEnv "PWD";
    in
    moduleWithSystem (
      { self', pkgs, ... }: {
        nixpkgs.overlays = [ (final: prev: { zsh = self'.packages.zsh; }) ];
        programs.zsh = {
          enable = true;
          promptInit = (builtins.readFile "${dotfiles}/dots/dot-zshrc"); # + "prompt off";
          shellAliases = {
            "nrs" = "sudo nixos-rebuild switch --flake ${flakePath}";
          };
        };
        users.defaultUserShell = pkgs.zsh;
      }
    );

  perSystem = { pkgs, ... }: {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;
      runtimePkgs = with pkgs; [
        starship
        fzf
      ];
    };
  };
}
