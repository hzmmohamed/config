{devenv, ...}: final: prev: {
  inherit (devenv.packages.${prev.system}) devenv;
}
