{ inputs, outputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [ wl-clipboard wofi-emoji swayr swaycons swayws ];
  # Sway
  wayland.windowManager.sway = {
    # Wrapped version of sway in nixpkgs already adds recommended command here in the sway docs https://github.com/swaywm/sway/wiki/Systemd-integration#managing-user-applications-with-systemd
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    wrapperFeatures.gtk = true;
    swaynag.enable = true;

    config =
      let cfg = config.wayland.windowManager.sway;
      in {
        modifier = "Mod4";
        floating.modifier = "Mod4";
        floating.border = 0;
        window.border = 0;
        bars = [{ command = "waybar"; }];
        focus.forceWrapping = false;
        focus.followMouse = true;
        terminal = "alacritty";
        startup = [ ];

        menu = "wofi --show drun";
        output = {
          eDP-1 = {
            scale = "1.2";
            mode = "1920x1080@60.002Hz";
            # bg = "";
          };
        };

        keybindings =
          let inherit (config.wayland.windowManager.sway.config.modifier);
          in lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${cfg.config.terminal}";
            "${modifier}+q" = "kill";
            "${modifier}+space" = "exec ${cfg.config.menu}";
            "${modifier}+h" = "split h";
            "${modifier}+v" = "split v";
            "${modifier}+f" = "fullscreen";
            "${modifier}+Shift+f" = "floating toggle";
            # change focus between tiling/floating windows
            "${modifier}+d" = "focus mode_toggle";
            # focus the parent container
            "${modifier}+p" = "focus parent";
            "${modifier}+Shift+s" = "exec flameshot gui";

            # focus the child container
            "${modifier}+c" = "focus child";

            "${modifier}+Shift+Return" =
              "exec swaymsg input 1:1:AT_Translated_Set_2_keyboard  xkb_switch_layout next";

            # Jump to urgent window
            "${modifier}+x" = "[urgent=latest] focus";

            "XF86AudioRaiseVolume" =
              "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%+";
            "XF86AudioLowerVolume" =
              "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%-";
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";

            # microphone
            "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";

            # playback
            ## play/pause
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioNext" = "exec playerctl next";
            "XF86AudioPrev" = "exec playerctl previous";

            # brightness
            "XF86MonBrightnessUp" = "exec light -A 5";
            "XF86MonBrightnessDown" = "exec light -U 5";
            "Shift+XF86MonBrightnessUp" = "exec light -A 1";
            "Shift+XF86MonBrightnessDown" = "exec light -U 1";

            # power
            "XF86PowerOff" = "exec $Locker";
          };
        modes.resize = {
          Escape = "mode default";
          Return = "mode default";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
        };

        gaps.inner = 15;
      };
    extraConfig = ''

      # set workspace labels
      set $ws1 "1: terminal"
      set $ws2 "2: file_manager"
      set $ws3 "3: notes"
      set $ws4 "4: browser"
      set $ws5 "5: coding"
      set $ws6 "6: gis"
      set $ws7 "7: db"
      set $ws8 "8: media"
      set $ws9 "9: teams"
      set $ws10 "0: generic"


      hide_edge_borders both
      default_border pixel 5


      ####################################
      ####       XF86 SHORTCUTS       ####
      ####################################

      # volume


      ##########################
      ####     INPUT     ####
      ##########################

      input type:touchpad {
          # Further options: https://wayland.freedesktop.org/libinput/doc/latest/configuration.html
             dwt enabled # disable while typing
             tap enabled
             natural_scroll disabled
             middle_emulation enabled
         }


      input "type:keyboard" {
          xkb_layout us,ara
      }

      ##########################
      ####     BAR          ####
      ##########################



      ######################################
      ####       WAYLAND CONFIG         ####
      ######################################

    '';
  };

  # Set env vars for wayland and sway

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    SDL_VIDEODRIVER = "wayland";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    _JAVA_AWT_WM_NONREPARENTING = 1;

    # gtk applications on wayland
    # GTK applications panic when the env var GDK_BACKEND is set globally to wayland. GTK will choose the appropriate backend (xwayland or wayland)
    # GDK_BACKEND = "wayland";
    # DISPLAY = ":1";

    # Seems to fix scaling in electron apps on wayland
    WLR_NO_HARDWARE_CURSORS = 1;

    # Fractional scaling
    NIXOS_OZONE_WL = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  # Sway-related tools
  services.swayidle = { enable = true; };
  programs.swaylock.enable = true;
}
