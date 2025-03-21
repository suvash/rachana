{ config, lib, pkgs, ... }:

{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # prime = {
    #   sync.enable = true;
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:2:0:0";
    #   # nvidiaBusId = ["PCI:1:0:0" "PCI:2:0:0"];
    # };
  };

  hardware.nvidia-container-toolkit = {
    enable = true;
  };

}
