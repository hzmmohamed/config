{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.tools.zellij;
in {
  options.caramelmint.tools.freetube = with types; {
    enable = mkBoolOpt false "Whether or not to enable freetube.";
  };

  config = mkIf cfg.enable {
    programs.freetube = {
      enable = true;
      settings = {
        quickBookmarkTargetPlaylistId = "favorites";
        baseTheme = "catppuccinFrappe";
        mainColor = "CatppuccinFrappeMauve";
        barColor = false;
        expandSideBar = false;
        hideHeaderLogo = true;
        hideLabelsSideBar = false;
        defaultViewingMode = "theatre";
        defaultQuality = "720";
        enableScreenshot = true;
        screenshotAskPath = true;
        hideTrendingVideos = true;
        hidePopularVideos = true;
        hideSubscriptionsShorts = true;
        hideSubscriptionsLive = true;
        hideChannelHome = false;
        hideChannelShorts = true;
        hideChannelPodcasts = true;
        playNextVideo = false;
        hideRecommendedVideos = true;
        hideCommentPhotos = true;
        showDistractionFreeTitles = true;
        hideSharingActions = true;
      };
    };

  };
}
