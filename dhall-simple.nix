{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-1.30.0-x86_64-macos.tar.bz2";
    sha256 = "03s4fj7i3jvnjk3faiqd77g46xxyj85i10jxrv2nvgy14kmx11cr";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-1.30.0-x86_64-linux.tar.bz2";
    sha256 = "00llrslfvlihfzryfvh8z2dz93nz1327h4ha2ks41k63x4fl4ib8";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
