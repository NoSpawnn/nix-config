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
        prefixVar = [
          [
            "XDG_DATA_DIRS"
            ":"
            "${pkgs.nerd-fonts._0xproto}/share"
          ]
        ];
        runtimePkgs = [ self'.packages.zsh ];
      }
    );
  };
}
