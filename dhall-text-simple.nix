{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";
  version = "1.0.14";
  dhall-version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall-version}/dhall-text-${version}-x86_64-linux.tar.bz2";
    sha256 = "1z3rxl9fmm9lqg8mlis36aybmvg3dhdz9pbgs1vs4dxk33ig6qmj";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall-to-text $out/bin/dhall-to-text
  '';
}
