{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-json-1.4.1-x86_64-macos.tar.bz2";
    sha256 = "1m5cw6b9xhr9qi55ih3dvkj7vzmh9jpswfqdadmw4r6rgsia8jg1";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-json-1.4.1-x86_64-linux.tar.bz2";
    sha256 = "0hv5x8ps0z74acsh91ivlg5vw7r0c8p0g92ca1mxm7m4p4vf936k";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
