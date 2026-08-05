{
  moduleWithSystem,
  inputs,
  dotfiles,
  ...
}:

{
  flake.nixosModules.nvim = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.nvim ]; }
  );

  perSystem = { pkgs, ... }: {
    packages.nvim = inputs.wrappers.wrappers.neovim.wrap {
      inherit pkgs;
      runtimePkgs = with pkgs; [
        fzf
        ripgrep
      ];
      env."CONFIG_ROOT" = "${dotfiles}/dots/dot-config/nvim";
      settings.config_directory = "${dotfiles}/dots/dot-config/nvim";
    };
  };
}
