# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  # TODO
  # sqlfmt = (
  #   pkgs.python310Packages.buildPythonPackage rec {
  #     pname = "shandy-sqlfmt";
  #     version = "0.20.0";
  #     src = pkgs.python310Packages.fetchPypi {
  #       inherit pname version;
  #       sha256 = "sha256-RGbT1Gpb898BKbCy+W8ZFr1ukaSrfa0s9oQEc4cwevA=";
  #     };
  #     doCheck = false;
  #     propagatedBuildInputs = with pkgs.python310Packages; [
  #       # Specify dependencies
  #       tomli
  #       tqdm
  #       click
  #       backports-cached-property
  #       platformdirs
  #       importlib-metadata
  #       gitpython
  #     ];
  #   }
  # );
}
