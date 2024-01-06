{
  options,
  config,
  lib,
  pkgs,
  ...
} @ inputs:
with lib;
with lib.plusultra; let
  cfg = config.caramelmint.desktop.sway;
in {
  options.caramelmint.desktop.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable and configure Sway.";
    wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
  };
  config = mkIf cfg.enable {
    # Desktop additions
    caramelmint.desktop.addons = {
      gtk = enabled;
      # wlogout = enabled;
      xdg-portal = enabled;
      light = enabled;
    };
    # plusultra.desktop.addons.electron-support = enabled;
    # TODO: Eleveate these kinds of settings that are not sway specific to desktop module
    caramelmint.hardware.touchpad = enabled;

    caramelmint.home.extraOptions = {
      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 17;
      };

      # TODO: Borrow a more featureful setup from jake's config or others.
      home.packages = with pkgs; [wl-clipboard wtype wofi-emoji swayr swaycons swayws qt6.qtwayland libsForQt5.qt5.qtwayland];
      services.swayidle = {enable = true;};
      programs.swaylock.enable = true;

      wayland.windowManager.sway = {
        enable = true;

        # TODO: Check if Nvidia is enabled
        extraOptions = ["--unsupported-gpu"];

        # Wrapped version of sway in nixpkgs already adds recommended command here in the sway docs https://github.com/swaywm/sway/wiki/Systemd-integration#managing-user-applications-with-systemd
        wrapperFeatures.gtk = true;

        swaynag.enable = true;

        # Generate sway config
        config = let
          modifier = "Mod4";
          menu = "wofi --show drun";
          terminal = "alacritty";
        in {
          modifier = modifier;
          floating.modifier = modifier;
          floating.border = 0;
          window.border = 0;
          bars = [{command = "waybar";}];
          focus.forceWrapping = false;
          focus.followMouse = true;
          terminal = terminal;
          # TODO: Create the term package or find another way
          # terminal = config.caramelmint.desktop.addons.term.pkg.name;
          startup = [];

          menu = menu;

          modes.resize = {
            Escape = "mode default";
            Return = "mode default";
            "Down" = "resize grow height 10 px or 10 ppt";
            "Left" = "resize shrink width 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";
            "Up" = "resize shrink height 10 px or 10 ppt";
          };

          gaps.inner = 15;
          keycodebindings = {

            "${modifier}+38" = "focus parent";

            "${modifier}+39" = "layout stacking";
            "${modifier}+25" = "layout tabbed";
            "${modifier}+26" = "layout toggle split";

            "${modifier}+Shift+54" = "reload";
            "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

            "${modifier}+r" = "mode resize";
            "${modifier}+Shift+24" = "kill";
            "${modifier}+Shift+44" = "exec ${pkgs.wofi-emoji}/bin/wofi-emoji";
            "${modifier}+43" = "splith";
            "${modifier}+55" = "splitv";
            "${modifier}+41" = "fullscreen toggle";
            "${modifier}+Shift+41" = "floating toggle";
            # change focus between tiling/floating windows
            # "${modifier}+d" = "focus mode_toggle"
            # focus the parent container
            "${modifier}+33" = "focus parent";
            "${modifier}+Shift+39" = "exec flameshot gui";

            # focus the child container
            "${modifier}+54" = "focus child";

            # Jump to urgent window
            "${modifier}+53" = "[urgent=latest] focus";
          };
          keybindings = let
            brightnessKeybindings = mkIf config.caramelmint.desktop.addons.light.enable {
              # brightness
              "XF86MonBrightnessUp" = "exec light -A 5";
              "XF86MonBrightnessDown" = "exec light -U 5";
              "Shift+XF86MonBrightnessUp" = "exec light -A 1";
              "Shift+XF86MonBrightnessDown" = "exec light -U 1";
            };
          in
            # lib.nixpkgs.attrsets.mergeAttrsList [
            {
              "${modifier}+Left" = "focus left";
              "${modifier}+Down" = "focus down";
              "${modifier}+Up" = "focus up";
              "${modifier}+Right" = "focus right";

              "${modifier}+Shift+Left" = "move left";
              "${modifier}+Shift+Down" = "move down";
              "${modifier}+Shift+Up" = "move up";
              "${modifier}+Shift+Right" = "move right";

              "${modifier}+1" = "workspace number 1";
              "${modifier}+2" = "workspace number 2";
              "${modifier}+3" = "workspace number 3";
              "${modifier}+4" = "workspace number 4";
              "${modifier}+5" = "workspace number 5";
              "${modifier}+6" = "workspace number 6";
              "${modifier}+7" = "workspace number 7";
              "${modifier}+8" = "workspace number 8";
              "${modifier}+9" = "workspace number 9";

              "${modifier}+Shift+1" = "move container to workspace number 1";
              "${modifier}+Shift+2" = "move container to workspace number 2";
              "${modifier}+Shift+3" = "move container to workspace number 3";
              "${modifier}+Shift+4" = "move container to workspace number 4";
              "${modifier}+Shift+5" = "move container to workspace number 5";
              "${modifier}+Shift+6" = "move container to workspace number 6";
              "${modifier}+Shift+7" = "move container to workspace number 7";
              "${modifier}+Shift+8" = "move container to workspace number 8";
              "${modifier}+Shift+9" = "move container to workspace number 9";

              "${modifier}+Shift+minus" = "move scratchpad";
              "${modifier}+minus" = "scratchpad show";

              "${modifier}+space" = "exec ${menu}";
              "${modifier}+Return" = "exec ${terminal}";
              "${modifier}+Shift+Return" = "exec swaymsg input 1:1:AT_Translated_Set_2_keyboard  xkb_switch_layout next";

              "XF86AudioRaiseVolume" = "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%+";
              "XF86AudioLowerVolume" = "exec wpctl set-volume --limit 1 @DEFAULT_SINK@ 5%-";
              "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";

              # microphone
              "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";

              # playback
              ## play/pause
              "XF86AudioPlay" = "exec playerctl play-pause";
              "XF86AudioNext" = "exec playerctl next";
              "XF86AudioPrev" = "exec playerctl previous";

              # power
              "XF86PowerOff" = "exec $Locker";

              # TODO: Temporary fix till I figure out how to properly merge two attrsets. The function used above seems to not work as expected. When used, Nix ignores the keybindings config and falls back to the default keybindings config.
              # brightness
              "XF86MonBrightnessUp" = "exec light -A 5";
              "XF86MonBrightnessDown" = "exec light -U 5";
              "Shift+XF86MonBrightnessUp" = "exec light -A 1";
              "Shift+XF86MonBrightnessDown" = "exec light -U 1";
            };
          # brightnessKeybindings
          # ];
        };

        # lib.nixpkgs.attrsets.mergeAttrsList [
        #   (
        #     import
        #     ./config/base.nix
        #     inputs
        #   )
        #   (
        #     import
        #     ./config/keybindings.nix
        #     (lib.nixpkgs.attrsets.mergeAttrsList [inputs {modifier = "Mod4";}])
        #   )
        # ];

        extraConfig = ''
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
        '';
        extraSessionCommands = ''
          # Reason for not setting this variable: https://github.com/NixOS/nixpkgs/issues/83603#issuecomment-1312652937
          # This was the solution to the problem of Cities Skylines crashing on startup
            # export SDL_VIDEODRIVER=wayland

            # needs qt5.qtwayland in systemPackages
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

            # Fix for some Java AWT applications (e.g. Android Studio),
            # use this if they aren't displayed properly:
            export _JAVA_AWT_WM_NONREPARENTING=1

            export MOZ_ENABLE_WAYLAND=1
            export MOZ_USE_XINPUT2=1


            export XDG_SESSION_TYPE=wayland
            export XDG_SESSION_DESKTOP=sway
            export XDG_CURRENT_DESKTOP=sway


            # Seems to fix scaling in electron apps on wayland
            export WLR_NO_HARDWARE_CURSORS=1;
            # Fractional scaling
            export NIXOS_OZONE_WL="1";
            export QT_AUTO_SCREEN_SCALE_FACTOR="1";
        '';
      };
    };

    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.sessionPackages = [pkgs.sway];
  };
}
