{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
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
            enable=true;
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
