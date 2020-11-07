{ pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./git.nix
    ./js.nix
    ./tmux.nix
    ./sh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.firefox pkgs.slack-dark pkgs.zoom-us pkgs.alacritty pkgs.elixir pkgs.spotify pkgs.docker pkgs.docker-compose pkgs.ripgrep ];

  time.timeZone = "America/New_York";
}
