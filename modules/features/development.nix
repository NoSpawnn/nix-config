{ self, moduleWithSystem, ... }:

{
  flake.nixosModules.development = moduleWithSystem (
    { pkgs, ... }: {
      imports = with self.nixosModules; [
        git
        lazygit
        nvim
        tmux
      ];

      environment.systemPackages = with pkgs; [ devenv ];
    }
  );
}
