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
          "nrs" = "sudo nixos-rebuild switch --flake";
          "nfu" = "nix flake update";

          # TODO: maybe put these in zshrc guarded behing _command_exists?;
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
        yazi
        starship
        fzf
        fd
      ];

    };
  };
}
