{ pkgs, ... }: {
  home.username = "joyboy";
  home.homeDirectory = "/home/joyboy";

  fonts.fontconfig.enable = true;

  home.enableNixpkgsReleaseCheck = false; #i don't fucking care
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    fastfetch
    graphite-gtk-theme
    firefox
    ddcutil
    cargo
    gcc
    better-control
    pavucontrol
    qpwgraph
    swaynotificationcenter
    kdePackages.dolphin
    nwg-look
    pamixer
    brightnessctl
    wlogout
    woomer
    jq
    eww
    hyprpolkitagent
    nil
    bash-language-server
    cava
    nixd
    waytrogen
    mpvpaper
    killall
    ayugram-desktop
    steam
    easyeffects
    vesktop
    hyprshot
    kitty
    btop
    curl
    git
    stow
    waybar
    wofi
# -------FONTS----------------------
    adwaita-fonts
    cantarell-fonts
    texlivePackages.gnu-freefont
    font-awesome
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    noto-fonts
    noto-fonts-color-emoji
    proggyfonts
    papirus-nord
    noto-fonts
    liberation_ttf
    roboto-mono
    font-awesome
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      source = ~/hyprland_config_home/hypr/hyprland.conf
    '';
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "cypher";
    };
    shellAliases = {
      shx="sudo -E hx $@";
      router="ssh root@OpenWrt";
      loadall="scp /home/joyboy/zapret-all root@OpenWrt:/opt/zapret/ipset";
      loadexclude="scp /home/joyboy/zapret-exclude root@OpenWrt:/opt/zapret/ipset";
      hl="start-hyprland";
      light="sudo ddcutil setvcp 10";
    };
  };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
