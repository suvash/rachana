{ config, lib, pkgs, ... }:

{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;

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
