{
  inputs,
  moduleWithSystem,
  dotfiles,
  ...
}:

{
  flake.nixosModules.zsh = moduleWithSystem (
    { self', pkgs, ... }: {
      users.defaultUserShell = pkgs.zsh;

      nixpkgs.overlays = [ (final: prev: { zsh = self'.packages.zsh; }) ];
      programs.zsh = {
        enable = true;
        promptInit = builtins.readFile "${dotfiles}/dots/dot-zshrc";
        shellAliases = {
          "nsh" = "nix-shell -p";
        };
      };
    }
  );

  perSystem = { pkgs, self', ... }: {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;
      env."STARSHIP_CONFIG" = "${dotfiles}dots/dot-config/starship.toml";
      runtimePkgs = with pkgs; [
        self'.packages.nvim
        eza
        fd
        fzf
        starship
        tealdeer
        yazi
        zoxide
      ];
    };
  };
}
