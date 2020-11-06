{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.gitAndTools.gitFull.overrideAttrs (oldAttrs: {
      userName = "gamburgm";
      userEmail = "mitch.gamburg@gmail.com";
    }))
  ];
}
