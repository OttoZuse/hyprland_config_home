# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# $NIX_PATH = /home/joyboy/.config/home-manager/home.nix

let
  unstable = import <unstable> {};
  # nix25_05 = import <nix25.05> {};
in
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./kernel.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap = {
    enable = true;
    algorithm = "lz4";  # Or "lz4" for speed, "zstd" for compression
    memoryPercent = 50; # Uses 50% of your total RAM as compressed swap
    priority = 10;      # Higher priority than disk-based swap
  };
  # config.services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "supermarket" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';
  # };

  nix.settings.auto-optimise-store = true;

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  networking.firewall.checkReversePath = "loose";
  networking.firewall.trustedInterfaces = [ "FlClashX" "Mihomo" "enp8s0" ];

  nix.settings.build-dir = "/heap/builds";

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.host.enableHardening = false;
  # users.extraGroups.docker.members = [ "joyboy" ];
  # virtualisation.docker.enable = true;
  # virtualisation.libvirtd.enable = true;
  # virtualisation.podman.enable = true;

  # nixpkgs.overlays = [
  #   (import /home/joyboy/ownKernelChannel/pkgs/linux-custom)
  # ];

  programs.direnv.enable = true;

  security.sudo.extraRules = [
    {
      users = [ "joyboy" ];
      commands = [
        {
          command = "/bin/light *";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";

  # boot.loader.grub.extraEntries = ''
  #   menuentry "NixOS (custom kernel)" {
  #     linux /boot/vmlinuz-6.18.6-zen-ga211f8de0e2e root=UUID=e4241a58-e352-4594-9a21-998ec326d382 rw
  #     initrd /boot/initrd
  #   }
  # '';

  boot.kernelPackages = unstable.linuxPackages_zen;

  boot.initrd.kernelModules = [ "amdgpu" "i2c-dev" "tun" "v4l2loopback" ];
  boot.extraModulePackages = [
    # pkgs.linuxKernel.packages.linux_zen.v4l2loopback
    config.boot.kernelPackages.v4l2loopback
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
#-------------flclashx---------------------
    gtk3
    gdk-pixbuf
    harfbuzz
    libz
    pango
    keybinder
    gobject-introspection
    glib
    gio-sharp
    fontconfig
    libdbusmenu
    gcc
    cairo
    atk
    ayatana-ido
    libepoxy
#------------------------------------------
    libnss_nis
    nss
    nspr
    expat
    alsa-lib
#-----------------commet-------------------
    mpv-unwrapped
    keybinder3
    libsoup_3
    webkitgtk_4_1
#------------------------------------------
    libGLX
    dbus
    libgit2
    stdenv.cc.cc.lib
    egl-wayland
    libfontenc
    freetype
    glib
    libGL
    xorg.libX11
    libz
    libkrb5
    zstd
    libxkbcommon
    stdenv
    libglibutil
    libxcb
    xcb-util-cursor
    libxkbcommon
    xcb-imdkit
    libxcb-keysyms
    libxcb
  ];

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  nixpkgs.config.allowUnfree = true;

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "onepc"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Omsk";

  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joyboy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "docker" ];
  #   packages = with pkgs; [
  #     tree
  #   ];
  };

  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = [
    unstable.helix
    pkgs.home-manager
    # pkgs.virtualbox
    pkgs.clang
    pkgs.clang-tools
    pkgs.lact
    pkgs.gnumake
    pkgs.cmake
    pkgs.clash-verge-rev
    pkgs.pkg-config
    pkgs.gcc
    pkgs.alsa-lib
    pkgs.cmake
    pkgs.bc
    pkgs.v4l-utils
    pkgs.droidcam
    pkgs.obs-studio-plugins.droidcam-obs
    pkgs.file
    pkgs.ntfs3g
    pkgs.sshfs
    pkgs.steam-run
    pkgs.ninja
    pkgs.lxqt.lxqt-policykit
    pkgs.matrix-synapse
    # pkgs.hyprpolkitagent
    # pkgs.virt-manager
    # pkgs.qemu_kvm
    # pkgs.vmware-workstation
  ];

  environment.variables = {
    EDITOR = "hx";
    HYPRSHOT_DIR = "/home/joyboy/Pictures";
    WINEARCH="win64";
    # XDG_SESSION_TYPE="x11";
  };

  environment.shells = with pkgs; [
    zsh
    bash
  ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.enable = true;
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  users.defaultUserShell = pkgs.zsh;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.printing.enable = true;
  services.resolved.enable = true;
  services.flatpak.enable = true;
  # services.dockerRegistry.enable = true;
  # services.ydotool.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}

