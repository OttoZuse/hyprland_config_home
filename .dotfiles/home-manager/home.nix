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
    pkgs.termdown
    unstable.throne
    unstable.element-desktop
    unstable.obsidian
    pkgs.ollama-rocm
    # unstable.open-webui
    pkgs.obs-studio
    pkgs.nix-ld
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
    pkgs.commonsCompress
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
    unstable.bottles-unwrapped
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
    pkgs.woomer
    pkgs.jq
    # pkgs.eww
    pkgs.hyprpolkitagent
    pkgs.nil
    pkgs.bash-language-server
    pkgs.cava
    pkgs.nixd
    pkgs.waytrogen
    pkgs.mpvpaper
    pkgs.killall
    unstable.ayugram-desktop
    unstable.steam
    pkgs.easyeffects
    unstable.vesktop
    pkgs.hyprshot
    pkgs.kitty
    pkgs.btop
    pkgs.curl
    pkgs.git
    pkgs.stow
    pkgs.waybar
    pkgs.wofi
# -------FONTS----------------------
    pkgs.adwaita-fonts
    pkgs.cantarell-fonts
    pkgs.texlivePackages.gnu-freefont
    pkgs.font-awesome
    pkgs.fira-code
    pkgs.fira-code-symbols
    # liberation_ttf
    # noto-fonts
    # noto-fonts-color-emoji
    # proggyfonts
    # papirus-nord
    # noto-fonts
    # liberation_ttf
    # roboto-mono
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = unstable.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      source = ~/hyprland_config_home/hypr/hyprland.conf
    '';
    # plugins = [
    #   unstable.hyprlandPlugins.hyprscrolling
    #   unstable.hyprlandPlugins.hy3
    # ];
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "cypher";
    };
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE=1;      
    };
    shellAliases = {
      shx="sudo -E hx $@";
      router="ssh root@OpenWrt";
      loadcfg = "scp /home/joyboy/config root@OpenWrt:/opt/zapret";
      loadall="scp /home/joyboy/zapret-all root@OpenWrt:/opt/zapret/ipset";
      loadexclude="scp /home/joyboy/zapret-exclude root@OpenWrt:/opt/zapret/ipset";
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
