{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-json-1.6.1-x86_64-macos.tar.bz2";
    sha256 = "1v4h36f0s57w9k7sd4p2xngvds9lsxfsmcx7jnqmgybw8zzvm5sq";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-json-1.6.1-x86_64-linux.tar.bz2";
    sha256 = "142jn8vaw8zf8qsmz1k23g0x9665i137gg13ip8jjmi1zcrzjrby";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
