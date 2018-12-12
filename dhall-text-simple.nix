{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-text-simple";
  version = "1.0.14";
  dhall-version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall-version}/dhall-text-${version}-x86_64-linux.tar.bz2";
    sha256 = "1z3rxl9fmm9lqg8mlis36aybmvg3dhdz9pbgs1vs4dxk33ig6qmj";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_TEXT=$out/bin/dhall-to-text
    install -D -m555 -T dhall-to-text $DHALL_TO_TEXT

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_TEXT --bash-completion-script $DHALL_TO_TEXT > $out/etc/bash_completion.d/dhall-to-text-completion.bash
  '';
}
