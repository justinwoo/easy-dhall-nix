{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-json-1.6.0-x86_64-macos.tar.bz2";
    sha256 = "1zj4h1hiq62lvkn8ic5rhzfgiachgq75s74zv94nkfi96xv994ih";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-json-1.6.0-x86_64-linux.tar.bz2";
    sha256 = "19xxlsn2xbhri6mvznas8hyk90l47w3lqf6y3lhmyaaqz81pd4dr";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
