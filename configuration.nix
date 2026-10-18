# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# $NIX_PATH = /home/joyboy/.config/home-manager/home.nix

let
  unstable = import <unstable> {};
  # nix25_05 = import <nix25.05> {};
  waybar = {
    url = "github:Alexays/Waybar";
    inputs.nixpkgs.follows = "nixpkgs"; 
  };
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
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];

  zramSwap = {
    enable = true;
    algorithm = "lz4";  # Or "lz4" for speed, "zstd" for compression
    memoryPercent = 100; # Uses 50% of your total RAM as compressed swap
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
  # stylix.targets.kde.enable = false;
  documentation.enable = true;
  services.tailscale.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  networking.firewall.checkReversePath = "loose";
  networking.firewall.trustedInterfaces = [ "FlClashX" "Mihomo" "enp8s0" ];

  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;

  nix.settings.build-dir = "/heap/builds";

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.host.enableHardening = false;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  # users.extraGroups.vboxusers.members = [ "joyboy" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
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

  boot.initrd.kernelModules = [
    "amdgpu"
    # "vboxdrv"
    # "vboxguest"
    "i2c-dev"
    "tun"
    "v4l2loopback"
  ];
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
    libayatana-appindicator
    libayatana-indicator
    glib
    gio-sharp
    fontconfig
    libdbusmenu
    gcc
    cairo
    atk
    ayatana-ido
    libepoxy
    libcupsfilters
    cups
    libXcomposite
    libXdamage
    libXext
    libXcursor
    libXfixes
    libXrandr
    libgdamm
    libgbm
    expat
    libxcb
    libxkbcommon
    devd
    alsa-lib    
    at-spi2-core
    libXtst
#------------------------------------------
    libnss_nis
    nss
    nspr
    expat
    alsa-lib
    alsa-tools
    alsa-firmware
#-----------------commet-------------------
    mpv-unwrapped
    keybinder3
    libsoup_3
    webkitgtk_4_1
#------------------------------------------
    libGLX
    freetype
    libGL
    dbus
    libgit2
    stdenv.cc.cc.lib
    egl-wayland
    libfontenc
    freetype
    glib
    libx11
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
#------------------------------------------
    sdl3
    sdl3-image
    sdl3-ttf
    fmodex
    fuse
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      rocmPackages.clr.icd # OpenCL
      libva # VA-API
    ];
  };

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
    extraGroups = [
      "adbusers"
      "wheel"
      "input"
      "networkmanager"
      "docker"
      # "vboxguest"
    ];
  #   packages = with pkgs; [
  #     tree
  #   ];
  };

  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.kdeconnect.enable = true;
  # programs.adb.enable = true;

  environment.systemPackages = [
    unstable.helix
    pkgs.home-manager
    pkgs.scrcpy
    # pkgs.android-udev-rules
    # unstable.virtualbox
    pkgs.clang
    # pkgs.bottles.override {removeWarningPopup = true;}
    pkgs.gparted
    pkgs.clang-tools
    pkgs.lact
    pkgs.gnumake
    pkgs.git
    pkgs.cmake
    pkgs.obs-studio-plugins.droidcam-obs
    pkgs.clash-verge-rev
    pkgs.pkg-config
    pkgs.gcc
    pkgs.alsa-firmware
    pkgs.alsa-lib
    pkgs.alsa-tools
    pkgs.cmake
    pkgs.bc
    pkgs.mesa-demos # OpenGL info
    pkgs.vulkan-tools # Khronos official Vulkan Tools and Utilities
    pkgs.clinfo # Print information about available OpenCL platforms and devices
    pkgs.libva-utils # Collection of utilities and examples for VA-API
    pkgs.v4l-utils
    pkgs.droidcam
    pkgs.file
    pkgs.ntfs3g
    pkgs.hdparm
    pkgs.sshfs
    pkgs.steam-run
    pkgs.ninja
    pkgs.stdenv.cc.cc.lib
    pkgs.fontconfig
    pkgs.lxqt.lxqt-policykit
    # pkgs.matrix-synapse
    # pkgs.hyprpolkitagent
    pkgs.virt-manager
    pkgs.sdl3
    pkgs.wowup-cf

    pkgs.kdePackages.kservice
    pkgs.kdePackages.kio-extras
    pkgs.kdePackages.kio
    # KDE Utilities
    pkgs.kdePackages.discover # Optional: Software center for Flatpaks/firmware updates
    pkgs.kdePackages.kcalc # Calculator
    pkgs.kdePackages.kcharselect # Character map
    pkgs.kdePackages.kclock # Clock app
    pkgs.kdePackages.kcolorchooser # Color picker
    pkgs.kdePackages.kolourpaint # Simple paint program
    pkgs.kdePackages.ksystemlog # System log viewer
    pkgs.kdePackages.sddm-kcm # SDDM configuration module
    pkgs.kdiff3 # File/directory comparison tool
    pkgs.appimage-run
    pkgs.ventoy
  
    # Hardware/System Utilities (Optional)
    pkgs.kdePackages.isoimagewriter # Write hybrid ISOs to USB
    pkgs.kdePackages.partitionmanager # Disk and partition management
    pkgs.hardinfo2 # System benchmarks and hardware info
    pkgs.wayland-utils # Wayland diagnostic tools
    pkgs.wl-clipboard # Wayland copy/paste support
    pkgs.vlc # Media player


    # pkgs.qemu_kvm
    # pkgs.vmware-workstation
    # (unstable.awakened-poe-trade.overrideAttrs (oldAttrs: {
    #   # Forces the electron wrapper to use the X11 platform instead of Wayland
    #   makeWrapperArgs = (oldAttrs.makeWrapperArgs or []) ++ [
    #     "--add-flags" "--enable-features=UseOzonePlatform"
    #     "--add-flags" "--ozone-platform=x11"
    #   ];
    # }))
  ];

  environment.variables = {
    # XDG_MENU_PREFIX="plasma- kbuildsycoca6";
    EDITOR = "hx";
    HYPRSHOT_DIR = "/home/joyboy/Pictures";
    WINEARCH="win64";
    # XDG_SESSION_TYPE="x11";
  };

  environment.shells = with pkgs; [
    zsh
    bash
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = [ "kde" ];
  };
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.kdePackages.xdg-desktop-portal-kde ];
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  users.defaultUserShell = unstable.zsh;

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
  services.lact.enable = true;

  # services = {
  #   desktopManager.plasma6.enable = true;
  #   displayManager.sddm.enable = true;
  #   displayManager.sddm.wayland.enable = true;
  # };

  # services.displayManager.ly.enable = true;

  # services.matrix-tuwunel = {
  #   enable = false;
  #   user = "joyboy";
    # package = unstable.matrix-tuwunel;
    # stateDirectory = "/var/lib";
    # extraEnvironment = {
    #   RUST_BACKTRACE = "yes";
    # };
  #   settings.global = {
  #     address = [ "127.0.0.1" "::1" ];
  #     trusted_servers = [ "matrix.org" "vorsente.com" ];
  #     server_name = "shmatrix.lox";
  #     port = [ 8008 ];
  #   };
  # };
  # networking.firewall.allowedTCPPorts = [ 8008 8448 ];
  # services.dockerRegistry.enable = true;
  # services.ydotool.enable = true;

  # Open ports in the firewall.
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
  xdg.mime.enable = true;
  xdg.menus.enable = true;
  environment.etc."xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  system.stateVersion = "25.11"; # Did you read the comment?
}

