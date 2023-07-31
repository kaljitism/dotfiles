{ inputs, pkgs, username, flake_path, ... }:
let 
    # Variables to share accross configs
    custom = {
        font = "RobotoMono Nerd Font";
        fontsize = "12";
        primary_accent = "cba6f7";
        secondary_accent= "89b4fa";
        tertiary_accent = "f5f5f5";
        background = "11111B";
        opacity = ".85";
        cursor = "Numix-Cursor";
    };
in
{
    imports =
        [ 
            ./packages.nix
            (import ./general {inherit (inputs) self;})
            (import ./themes {inherit pkgs custom;})
            (import ./wayland {inherit pkgs custom;})
        ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true; # This is borked for some reason :D
    nixpkgs.config.allowUnfreePredicate = _: true; # Workaround for the above borked option
    home.shellAliases = {
        home-switch = "home-manager switch --flake ${flake_path}#${username}";
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.11";
    }
