{
  moduleWithSystem,
  dotfiles,
  inputs,
  ...
}:

{
  flake.nixosModules.foot = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.foot ]; }
  );

  perSystem = { self', pkgs, ... }: {
    packages.foot = inputs.wrappers.wrappers.foot.wrap (
      { ... }: {
        inherit pkgs;
        constructFiles.generatedConfig.content = builtins.readFile "${dotfiles}/dots/dot-config/foot/foot.ini";
        runtimePkgs = [
          self'.packages.zsh
          pkgs.nerd-fonts._0xproto
        ];
      }
    );
  };
}
