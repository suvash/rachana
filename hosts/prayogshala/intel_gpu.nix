{ config, lib, pkgs, ... }:

{

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.useGlamor = true;

}
