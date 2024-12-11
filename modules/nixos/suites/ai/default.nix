{ options, config, lib, pkgs, ... }:
with lib;
with lib.caramelmint;
let cfg = config.caramelmint.suites.ai;
in {
  options.caramelmint.suites.ai = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable configuration for AI tools";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };
    services.nextjs-ollama-llm-ui = {
      enable = true;
      port = 3030;
    };
    environment.systemPackages = with pkgs; [ openai-whisper-cpp ];
  };
}
