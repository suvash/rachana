# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/76d30960-f9f1-408d-b856-8c056258d1ca";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6460-23F7";
      fsType = "vfat";
    };

  fileSystems."/workspace" =
    { device = "/dev/disk/by-uuid/dabad67f-ac7b-4ba3-a018-803c49b6c84f";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/86019065-c7bc-413e-bb09-295f98c7636f"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
