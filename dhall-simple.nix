{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-1.27.0-x86_64-macos.tar.bz2";
    sha256 = "0jwj46d9wnq6jzp9as826y98mc73z8xmq73yznkmlfk8sh26ph01";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-1.27.0-x86_64-linux.tar.bz2";
    sha256 = "1ig6vgdkw631gdwcymfx02pwxql42rldb9w7rbqrqr4b4xww6r3q";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
