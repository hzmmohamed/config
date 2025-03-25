{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.desktop.addons.waybar;
in {
  options.caramelmint.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        main-bar = {
          layer = "top";
          position = "right";
          reload_style_on_change = true;
          modules-left =
            [ "custom/notification" "clock" "custom/pacman" "tray" ];
          modules-center = [ "sway/workspaces" ];
          modules-right = [ "group/expand" "battery" ];
          "sway/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              default = "○";
              empty = "○";
            };
            persistent-workspaces = { "*" = [ 1 2 3 4 5 6 7 8 9 ]; };
          };
          "custom/notification" = {
            tooltip = false;
            format = "";
            on-click = "swaync-client -t -sw";
            escape = true;
          };
          clock = {
            format = "{:%I:%M:%S %p} ";
            interval = 1;
            "rotate" = 270;
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
            };
          };
          network = {
            format-wifi = "";
            format-ethernet = "";
            format-disconnected = "";
            tooltip-format-disconnected = "Error";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} 🖧 ";
            # on-click = "kitty nmtui";
          };
          bluetooth = {
            format-on = "󰂯";
            format-off = "BT-off";
            format-disabled = "󰂲";
            format-connected-battery = "{device_battery_percentage}% 󰂯";
            format-alt = "{device_alias} 󰂯";
            tooltip-format = ''
              {controller_alias}	{controller_address}

              {num_connections} connected'';
            tooltip-format-connected = ''
              {controller_alias}	{controller_address}

              {num_connections} connected

              {device_enumerate}'';
            tooltip-format-enumerate-connected = ''
              {device_alias}
              {device_address}'';
            tooltip-format-enumerate-connected-battery = ''
              {device_alias}
              {device_address}
              {device_battery_percentage}%'';
            on-click-right = "blueman-manager";
          };
          battery = {
            interval = 30;
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            rotate = 270;
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% 󰂄 ";
            format-alt = "{time} {icon}";
            format-icons = [ "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          };

          "custom/expand" = {
            format = "^";
            tooltip = false;
          };
          "custom/endpoint" = {
            format = "|";
            tooltip = false;
          };
          "group/expand" = {
            orientation = "vertical";
            drawer = {
              transition-duration = 600;
              transition-to-left = true;
              click-to-reveal = true;
            };
            modules = [
              "custom/expand"
              "custom/colorpicker"
              "cpu"
              "memory"
              "temperature"
              "custom/endpoint"
            ];
          };
          "custom/colorpicker" = {
            format = "{}";
            return-type = "json";
            interval = "once";
            exec = "~/.config/waybar/scripts/colorpicker.sh -j";
            on-click = "~/.config/waybar/scripts/colorpicker.sh";
            signal = 1;
          };
          cpu = {
            format = "󰻠";
            tooltip = true;
          };
          memory = { format = ""; };
          temperature = {
            critical-threshold = 80;
            format = "";
          };
          tray = {
            icon-size = 14;
            spacing = 10;
          };
        };
      };
      style = ''
                    * {
                  /* reference the color by using @color-name */
                  color: @text;
                }

                
        window#waybar{
            background: transparent;
        }
                * {
                    font-size:12px;
                    font-family: "FiraCode Nerd Font Propo";
                }

                .modules-left {
                    border-radius:10px;
                    background: alpha(@base,.8);
                    box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                }
                .modules-center {
                    border-radius:10px;
                    background: alpha(@base,.8);
                    box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                }
                .modules-right {
                    border-radius:10px;
                    background: alpha(@base,.8);
                    box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                }
                tooltip {
                    background:@base;
                    color: @lavender;
                }

                #clock:hover, #custom-pacman:hover, #custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover{
                    transition: all .3s ease;
                    color:@text;
                    background:alpha(@base,.9);
                }
                #custom-notification {
                    transition: all .3s ease;
                    color:@text;
                }
                #clock{
                    color:@text;
                    transition: all .3s ease;
                }

                #workspaces button {
                    all:unset;
                    color: alpha(@text,.4);
                    transition: all .2s ease;
                }
                #workspaces button:hover {
                    color:rgba(0,0,0,0);
                    border: none;
                    text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
                    transition: all 1s ease;
                }
                #workspaces button.active {
                    color: @lavender;
                    border: none;
                    text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
                }
                #workspaces button.empty {
                    color: rgba(0,0,0,0);
                    border: none;
                    text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
                }
                #workspaces button.empty:hover {
                    color: rgba(0,0,0,0);
                    border: none;
                    text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
                    transition: all 1s ease;
                }
                #workspaces button.empty.active {
                    color: @text;
                    border: none;
                    text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
                }
                #bluetooth{
                    transition: all .3s ease;
                    color:@text;

                }
                #network{
                    transition: all .3s ease;
                    color:@text;

                }
                #battery{
                    transition: all .3s ease;
                    color:@text;


                }
                #battery.charging {
                    color: #26A65B;
                }

                #battery.warning:not(.charging) {
                    color: #ffbe61;
                }

                #battery.critical:not(.charging) {
                    color: #f53c3c;
                    animation-name: blink;
                    animation-duration: 0.5s;
                    animation-timing-function: linear;
                    animation-iteration-count: infinite;
                    animation-direction: alternate;
                }
                #group-expand{
                    transition: all .3s ease; 
                }
                #custom-expand{
                    color:alpha(@foreground,.2);
                    text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
                    transition: all .3s ease; 
                }
                #custom-expand:hover{
                    color:rgba(255,255,255,.2);
                    text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
                }
                #custom-colorpicker{
                }
                #cpu,#memory,#temperature{
                    transition: all .3s ease; 
                    color:@text;

                }
                #custom-endpoint{
                    color:transparent;
                    text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);

                }
                #tray{
                    transition: all .3s ease; 

                }
                #tray menu * {
                    transition: all .3s ease; 
                }

                #tray menu separator {
                    transition: all .3s ease; 
                }
      '';
    };
  };
}
