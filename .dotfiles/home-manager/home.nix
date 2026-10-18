let
  unstable = import <unstable> { config = {allowUnfree = true; }; };
  nix25_05 = import <nix25.05> { config = {allowUnfree = true; }; };
in
{ pkgs, ... }: {
  home.username = "joyboy";
  home.homeDirectory = "/home/joyboy";

  # programs.nix-ld.enable = false;

  # services.lorri.enable = true;

  fonts.fontconfig.enable = true;

  home.enableNixpkgsReleaseCheck = false; #i don't fucking care
  nixpkgs.config.allowUnfree = true;
  # home-manager.useGlobalPkgs = true;

  home.packages = [
    # pkgs.droidcam
    pkgs.mapscii
    pkgs.tcpdump
    pkgs.intelephense
    pkgs.geekbench
    pkgs.furmark
    pkgs.unigine-heaven
    pkgs.gopls
    pkgs.go
    pkgs.nix-diff
    pkgs.php
    pkgs.lua
    # pkgs.lua-language-server
    pkgs.nmap
    pkgs.foliate
    pkgs.pv
    pkgs.chromium
    # pkgs.flclash
    pkgs.rusty-path-of-building
    pkgs.lutris
    # pkgs.wowup-cf
    pkgs.minesweep-rs
    pkgs.audacious
    pkgs.opencode-desktop
    pkgs.gamemode
    # pkgs.awakened-poe-trade
    pkgs.unzip
    pkgs.dpkg
    # pkgs.anydesk
    pkgs.soundconverter
    pkgs.steam-run-free
    pkgs.termdown
    pkgs.quickshell
    unstable.discord
    pkgs.gamemode
    pkgs.parallel
    unstable.element-desktop
    unstable.obsidian
    pkgs.ollama-rocm
    # unstable.open-webui
    pkgs.obs-studio
    unstable.nix-ld
    unstable.winetricks
    unstable.wine
    pkgs.php
    pkgs.fastfetch
    pkgs.kdePackages.filelight
    # pkgs.kdePackages.kdenlive
    pkgs.asciiquarium
    pkgs.sqlite
    pkgs.sqlitestudio
    # pkgs.qwen-code
    pkgs.commons-compress
    pkgs.links2
    pkgs._7zz-rar
    pkgs.iperf2
    # pkgs.media-downloader
    pkgs.yt-dlg
    pkgs.songrec
    pkgs.minesweep-rs
    pkgs.mpv
    pkgs.cppman
    pkgs.onlyoffice-desktopeditors
    pkgs.qbittorrent
    pkgs.protonup-ng
    pkgs.bottles
    pkgs.dotool
    pkgs.wlrctl
    pkgs.ccls
    pkgs.actiona
    pkgs.llvmPackages_20.clang-unwrapped
    pkgs.lldb
    pkgs.graphite-gtk-theme
    unstable.firefox
    pkgs.ddcutil
    pkgs.cargo
    pkgs.gcc
    pkgs.better-control
    pkgs.pavucontrol
    pkgs.qpwgraph
    pkgs.swaynotificationcenter
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.gwenview
    pkgs.kdePackages.kolourpaint
    pkgs.nwg-look
    pkgs.pamixer
    pkgs.wlogout
    unstable.woomer
    pkgs.jq
    # pkgs.eww
    pkgs.hyprpolkitagent
    pkgs.nil
    # pkgs.bash-language-server
    pkgs.cava
    pkgs.nixd
    unstable.waytrogen
    pkgs.mpvpaper
    pkgs.killall
    unstable.ayugram-desktop
    unstable.steam
    unstable.easyeffects
    pkgs.vesktop
    pkgs.hyprshot
    pkgs.kitty
    pkgs.btop
    pkgs.curl
    pkgs.git
    pkgs.stow
    pkgs.wofi
# -------FONTS----------------------
    pkgs.adwaita-fonts
    pkgs.cantarell-fonts
    pkgs.texlivePackages.gnu-freefont
    pkgs.font-awesome
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.courier-prime
    pkgs.courier-unicode
    pkgs.monaspace
    # liberation_ttf
    # noto-fonts
    # noto-fonts-color-emoji
    # proggyfonts
    # papirus-nord
    # noto-fonts
    # liberation_ttf
    # roboto-mono
  ];
  programs.waybar = {
    enable = true;
    package = (builtins.getFlake "github:Alexays/Waybar").packages.${pkgs.stdenv.hostPlatform.system}.waybar;
  };
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland = {
    enable = true;
    package = unstable.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      dofile("/home/joyboy/hypr/hyprland.lua")
    '';
    # plugins = [
    #   unstable.hyprlandPlugins.hyprscrolling
    #   unstable.hyprlandPlugins.hy3
    # ];
  };
  # languages.rust = {
  #   channel = "nightly";
  #   components = [
  #     "cargo"
  #     "rust-src"
  #     "rustc"
  #   ];
  #   enable = true;
  # };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "cypher";
    };
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE=1;
      NIXPKGS_ALLOW_INSECURE=1;
      XDG_SESSION_TYPE="x11";
    };
    shellAliases = {
      shx="sudo -E hx $@";
      router="ssh root@192.168.1.1";
      loadcfg = "scp /home/joyboy/config root@192.168.1.1:/opt/zapret";
      loadall="scp /home/joyboy/zapret-all root@192.168.1.1:/opt/zapret/ipset";
      loadexclude="scp /home/joyboy/zapret-exclude root@192.168.1.1:/opt/zapret/ipset";
      hl="start-hyprland";
      bl="sudo /bin/light";
    };
  };

  # programs.bottles = {
  #   override.removeWarningPopup = true;
  # };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
