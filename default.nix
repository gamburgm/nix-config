{ pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./git.nix
    ./js.nix
    ./tmux.nix
    ./sh.nix
  ];

  environment.systemPackages = [ pkgs.alacritty pkgs.elixir ];
}
