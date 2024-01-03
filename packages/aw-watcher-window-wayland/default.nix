{
  pkgs,
  lib,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "aw-watcher-window-wayland";
  version = "56b4296";

  src = pkgs.fetchFromGitHub {
    owner = "activitywatch";
    repo = pname;
    rev = version;
    sha256 = "sha256-qJTr3/74/kt5JNXjHNp6DzmE8u6gmoyHp7QUNwuW100=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "aw-client-rust-0.1.0" = "sha256-9tlVesnBeTlazKE2UAq6dzivjo42DT7p7XMuWXHHlnU=";
    };
  };
  nativeBuildInputs = with pkgs; [pkg-config];

  buildInputs = with pkgs; [bzip2 openssl];

  meta = {
    description = "window and afk watcher for wayland";
    homepage = "https://github.com/activitywatch/aw-watcher-window-wayland";
  };
}
