{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-1.26.1-x86_64-macos.tar.bz2";
    sha256 = "1mdgjcwpar53h8dmhq4x3n7s6idinzxyim6g2z1d7r7dwjqmmll6";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-1.26.1-x86_64-linux.tar.bz2";
    sha256 = "0sl4r3mfairgd6kn26hs1r1lkh8rn992grd73078rhqf5w90ag05";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
