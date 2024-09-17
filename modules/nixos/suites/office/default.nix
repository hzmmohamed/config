{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.caramelmint; let
  cfg = config.caramelmint.suites.office;
in {
  options.caramelmint.suites.office = with types; {
    enable =
      mkBoolOpt false
      "Whether or not to enable common office productivity configuration.";
  };

  config = mkIf cfg.enable {
    services.gnome.glib-networking = enabled;
    caramelmint = {
      apps = {
        vscode = enabled;
      };

      tools = {
        # espanso = enabled;
        obsidian = enabled;
        activity-watch = enabled;
      };

      virtualisation = {kvm = enabled;};

      home.extraOptions = {
        home.sessionVariables = {
          GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
        };

        services.kdeconnect = {
          enable = true;
          indicator = true;
        };
        services.flameshot.enable = true;

        programs = {
          chromium = {
            enable = true;
            package = pkgs.unstable.chromium;
            extensions = [
              {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
              {id = "chphlpgkkbolifaimnlloiipkdnihall";} # OneTab

              {id = "ekhagklcjbdpajgpjgmbionohlpdbjgc";} # Zotero Connector
              {id = "blkggjdmcfjdbmmmlfcpplkchpeaiiab";} # Omnivore

              {id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi";} # Google Docs Offline

              {id = "pmjeegjhjdlccodhacdgbgfagbpmccpe";} # Clockify Time Tracker
              {id = "oejclklollnadllgjcpaopapmckpeaim";} # Weekly Clockify

              {id = "nglaklhklhcoonedhgnpgddginnjdadi";} # Activity Watcher
              {id = "fpnmgdkabkmnadcjpehmlllkndpkmiak";} # Wayback Machine
            ];
          };
          firefox = {
            enable = true;
            # TODO: Define extensions here as well. Refer to vimjoyer's video
            policies = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            };

            profiles.hfahmi = {
              search.engines = {
                "Nix Packages" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];

                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["@np"];
                };
              };
              search.force = true;

              bookmarks = [
                {
                  name = "wikipedia";
                  tags = ["wiki"];
                  keyword = "wiki";
                  url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
                }
              ];

              settings = {
                "dom.security.https_only_mode" = true;
                "browser.download.panel.shown" = true;
                "identity.fxaccounts.enabled" = false;
                "signon.rememberSignons" = false;
              };

              # userChrome = ''
              #   .tabbrowser-tab {
              #     visibility: collapse;
              #   }
              #   .titlebar-button {
              #     height: 27px !important;
              #   }
              #   #nav-bar {
              #     margin-top: -42px;
              #     margin-right: 140px;
              #     box-shadow: none !important;
              #   }

              #   [uidensity="compact"]:root .titlebar-button {
              #     height: 32px !important;
              #   }
              #   [uidensity="compact"]:root #nav-bar {
              #     margin-top: -32px;
              #   }

              #   #titlebar-spacer {
              #     background-color: var(--chrome-secondary-background-color);
              #   }
              #   #titlebar-buttonbox-container {
              #     background-color: var(--chrome-secondary-background-color);
              #   }
              #   .titlebar-color {
              #     background-color: var(--toolbar-bgcolor);
              #   }

              #   #main-window[inFullscreen="true"] #sidebar-box,
              #   #main-window[inFullscreen="true"] #sidebar-box + splitter {
              #       visibility: collapse;
              #   }

              #   #sidebar-box #sidebar-header {
              #     display: none !important;
              #   }

              # '';

              # TODO: Remove platform specific string here
              extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                bitwarden

                # TODO: Put the vertical tabs configuraiton behind a single flag in a dedicated module
                tree-style-tab
                aw-watcher-web
                youtube-shorts-block
                # tridactyl

                # block-origin
                # sponsorblock
                # arkreader
              ];
            };
          };
        };

        home.packages = with pkgs; [
          unstable.obsidian
          zotero
          libreoffice
          onedriver
          glib-networking
          pcmanfm
          # lf should be moved to a module with an elaborate configuration
          lf
          ktorrent
          unstable.anytype
          pdfgrep
          spotify

          fontfor
          fontforge
          font-manager
        ];
      };
    };
  };
}
