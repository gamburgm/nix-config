{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = ''
      set -sg escape-time 0
      set -ga terminal-overrides "*256col*:Tc"
    '';
  };
}
