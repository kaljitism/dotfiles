# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      luks.devices."cryptpart".device = "/dev/disk/by-uuid/ade7c385-a68c-40f3-9fae-8e997aa0dee3";
    };
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_zen;
  };

  fileSystems = {
    "/" = { 
      device = "/dev/mapper/cryptpart";
      fsType = "btrfs";
      options = [ "compress=zstd:1" "noatime" "subvol=root" ];
    };
    "/home" = { 
      device = "/dev/mapper/cryptpart";
      fsType = "btrfs";
      options = [ "compress=zstd:1" "noatime" "subvol=home" ];
    };
    "/nix" = { 
      device = "/dev/mapper/cryptpart";
      fsType = "btrfs";
      options = [ "compress=zstd:1" "noatime" "subvol=nix" ];
    };
    "/boot" = { 
      device = "/dev/disk/by-uuid/D586-8FFE";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

