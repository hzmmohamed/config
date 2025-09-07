{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.apps.vscode;
in {
  options.caramelmint.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether to enable and configure VSCode.";
  };

  config = mkIf cfg.enable {

    caramelmint.home.extraOptions = {
      catppuccin = { vscode.enable = false; };

      #  Install and Configure VSCodium
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        mutableExtensionsDir = true; # default
        profiles.default.extensions = with pkgs.vscode-extensions; [
          pkgs.unstable.vscode-extensions.continue.continue

          tomoki1207.pdf
          # Theming
          emmanuelbeziat.vscode-great-icons

          # Git
          donjayamanne.githistory
          mhutchie.git-graph

          mikestead.dotenv
          editorconfig.editorconfig
          naumovs.color-highlight
          vincaslt.highlight-matching-tag
          yoavbls.pretty-ts-errors

          # Programming language tooling
          # Python
          ms-python.python
          ms-toolsai.jupyter
          ms-toolsai.vscode-jupyter-slideshow
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.jupyter-renderers
          ms-toolsai.jupyter-keymap
          # Shell
          foxundermoon.shell-format
          # PlantUML
          jebbs.plantuml
          # Go
          golang.go
          # OpenSCAD
          antyos.openscad
          # Nix
          kamadorueda.alejandra
          jnoortheen.nix-ide

          redhat.vscode-yaml

          marp-team.marp-vscode

          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons

          # Commented because it's not found in the extensions flake
          # joaompinto.vscode-graphviz 
          # activitywatch.aw-watcher-vscode
          # openfga.openfga-vscode

          mkhl.direnv

          graphql.vscode-graphql
          graphql.vscode-graphql-syntax


          # vscode-tree-sitter-query

          # fcrespo82.markdown-table-formatter
        ];

      };

      # Allow mutable settings.json at runtime, and rewritten on running `home-manager switch`
      # Reference: https://github.com/nix-community/home-manager/issues/1800
      home.activation.afterWriteBoundary = let
        userSettings = {
          "window.vscodeLevel" = 1;
          "workbench.sideBar.location" = "right";
          "workbench.colorTheme" = "Catppuccin Latte";
          "files.autoSave" = "afterDelay";
          "files.autoSaveDelay" = 1000;
          "editor.wordWrap" = "on";
          "nix.serverPath" = "nil";
          "editor.fontFamily" =
            "'FiraCode Nerd Font Mono', 'monospace', monospace";
          "workbench.startupEditor" = "none";
        };
        configDir = "VSCodium";
        # TODO: High Priority: Find a way to access the final home-manager config
        userSettingsDirPath = "/home/hfahmi/.config/${configDir}/User";
        userSettingsFilePath = "${userSettingsDirPath}/settings.json";
      in {
        after = [ "writeBoundary" ];
        before = [ ];
        data = ''
          mkdir -p ${userSettingsDirPath}
          cat ${
            pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings)
          } | ${pkgs.jq}/bin/jq --monochrome-output > ${userSettingsFilePath}
        '';
      };
    };
  };
}
