{ config, pkgs, ... }:

{
  home.username = "zfadli";  # Replace with your actual username
  home.homeDirectory = "/home/zfadli"; # Replace accordingly

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Install Sway and essential utilities
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      alacritty       # Terminal emulator
      swaylock        # Screen locker
      swayidle        # Idle management
      waybar          # Status bar
      rofi-wayland    # Application launcher
      dmenu           # Alternative launcher
      wl-clipboard    # Clipboard support
      mako           # Notification daemon
    ];
  };

  # Configure Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.size = 12;
    };
  };

  # Set environment variables for Wayland
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
  };

  # Home Manager needs to know this
  home.stateVersion = "23.11"; # Use the latest stable NixOS version
}
