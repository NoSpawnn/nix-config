{ ... }:

{
  home.shell.enableBashIntegration = true;

  programs = {
    direnv.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    tmux.enable = true;
    zoxide.enable = true;

    neovim = {
      enable = true;
      sideloadInitLua = true;
      withRuby = false;
      withPython3 = false;
    };
  };

  programs.home-manager.enable = true;
}
