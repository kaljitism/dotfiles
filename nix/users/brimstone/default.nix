{ profile, inputs, username, flake_path, pkgs, pkgsStable, ... }:
let 
  # Variables to share accross configs
  custom = {
    font = "RobotoMono Nerd Font";
    fontsize = "12";
    primary_accent = "cba6f7";
    secondary_accent= "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = "1";
    cursor = "Numix-Cursor";
    palette = import ./colors.nix;
  };
in
{
  # Brimstone is my main everyday home configuration, including a number
  # of tools and services i use on a daily basis
  _module.args = { inherit pkgsStable profile inputs username custom; };
  imports = [ 
    ../base/configuration.nix
    ../base/wayland
    ../base/themes
    ../base/programs
    ../base/services
    ../base/editors
  ];
  home.packages = with pkgs; [
    brave 
    firefox
    gimp
    mpv
    neofetch
    obs-studio
    prismlauncher
    speedtest-cli
    telegram-desktop
    vial
    imagemagick
    jellyfin-media-player
    element-desktop
  ];
}
