{ lib, ... }:

{
  boot.kernelPackages = lib.mkForce null;

  boot.kernelFile = "/home/joyboy/vmlinuz-6.18.6-zen-ga211f8de0e2e";

  boot.kernelModules = [];

  boot.extraModulePackages = [];

  boot.initrd.availableKernelModules = lib.mkForce [];

  boot.initrd.kernelModules = lib.mkForce [];

  boot.kernelParams = [
    "modules_load=on"
  ];
}
