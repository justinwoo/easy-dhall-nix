{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-1.26.0-x86_64-macos.tar.bz2";
    sha256 = "0jy9bwgywqwb7nk1qhpqhi56g7fsk8vhzybwxb8h07qcm47wa6vw";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-1.26.0-x86_64-linux.tar.bz2";
    sha256 = "0q6zdkf1grzj1hblx1ngdfss41bisl7a3fz9xl9zz229s7n5grq5";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
