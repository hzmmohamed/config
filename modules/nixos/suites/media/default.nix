{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.media;
in {
  options.caramelmint.suites.media = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common configuration for media tools.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      programs.mpv.enable = true;

      services.playerctld.enable = true;
      # services.mpris-proxy.enable = true;

      home.packages = with pkgs; [
        # media
        vlc
        digikam
        ytfzf
        ffmpeg_5
        handbrake
        playerctl
      ];
    };
  };
}
