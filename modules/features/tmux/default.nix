{
  moduleWithSystem,
  inputs,
  dotfiles,
  ...
}:

{
  flake.nixosModules.tmux = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.tmux ]; }
  );

  perSystem = { pkgs, ... }: {
    packages.tmux = inputs.wrappers.wrappers.tmux.wrap {
      inherit pkgs;
      runtimePkgs = [ pkgs.yazi ];
      constructFiles.generatedConfig.content = "${dotfiles}/dots/dot-config/tmux/tmux.conf";
    };
  };
}
