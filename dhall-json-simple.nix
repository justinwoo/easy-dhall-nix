{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-json-1.6.2-x86_64-macos.tar.bz2";
    sha256 = "02j0lg285a1a7w4rxcmvvn3fxyn5mnxrrgzdn8j4yjdbizkq13lx";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-json-1.6.2-x86_64-linux.tar.bz2";
    sha256 = "1wzlxcfvw1nf6g5rhnsd7g079f25n569s2gg7prrly0r9ry64dza";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
