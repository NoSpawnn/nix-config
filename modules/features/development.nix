{ self, moduleWithSystem, ... }:

{
  flake.nixosModules.development = moduleWithSystem (
    { pkgs, ... }: {
      imports = with self.nixosModules; [
        git
        lazygit
        nvim
      ];

      environment.systemPackages = with pkgs; [
        tmux
        devenv
      ];
    }
  );
}
