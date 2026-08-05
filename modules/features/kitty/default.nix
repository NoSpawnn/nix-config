{
  moduleWithSystem,
  dotfiles,
  inputs,
  ...
}:

{
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.kitty ]; }
  );

  perSystem = { self', pkgs, ... }: {
    packages.kitty = inputs.wrappers.wrappers.kitty.wrap (
      { ... }: {
        inherit pkgs;
        runtimePkgs = [
          self'.packages.zsh
          pkgs.nerd-fonts._0xproto
        ];
        extraConfig = builtins.readFile "${dotfiles}/dots/dot-config/kitty/kitty.conf";
      }
    );
  };
}
