{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.jq pkgs.aws ];
}
