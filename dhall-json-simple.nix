{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-json-1.4.1-x86_64-macos.tar.bz2";
    sha256 = "147cbc5fw6iaynmyz4iz5r9bmq7kldhjvzj6pa4l10i4asal7da1";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-json-1.4.1-x86_64-linux.tar.bz2";
    sha256 = "1hpd3rwpawwgpb5v2ib5hnsl1jbw4p109hhd6qhi2fc8rd7g5s89";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
