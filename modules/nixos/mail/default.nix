{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.mail;
in {
  options.caramelmint.mail = with types; {
    enable = mkBoolOpt false "Whether or not to enable my email accounts.";
  };

  config = mkIf cfg.enable {
    caramelmint.home.extraOptions = {
      programs.thunderbird = {
        enable = true;
        profiles = {
          hfahmi = {
            isDefault = true;
            search.default = "DuckDuckGo";
          };
        };
      };
      accounts = {
        email.accounts = {
          personal = {
            address = "hzmmohamed@gmail.com";
            flavor = "gmail.com";
            thunderbird = {
              enable = true;
              profiles = [ "hfahmi" ];
              settings = id: {
                # Gmail only allowed OAuth2 authentication method
                # 10 is a code for OAuth2. I tried all the numbers from 1 through 10 to finally find that out. You're welcome!
                "mail.server.server_${id}.authMethod" = 10;
                "mail.smtpserver.smtp_${id}.authMethod" = 10;

                "mail.server.server_${id}.autosync_max_age_days" = 30;
              };
            };
            primary = true;
            realName = "Hazem Fahmi";
            signature = {
              delimiter = "--";
              text = ''
                Hazem Fahmi
              '';
              showSignature = "append";
            };
          };
        };
      };
    };
  };
}
