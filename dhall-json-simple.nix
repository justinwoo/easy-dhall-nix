{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-json-1.5.0-x86_64-macos.tar.bz2";
    sha256 = "0gxbxnfzhj2q1q64yjiz64vqblka5x52g491dhnsh80g59f9zb6j";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-json-1.5.0-x86_64-linux.tar.bz2";
    sha256 = "0anccnsl350w0xw2nacacma0lvnpx9dfwrsc3lxvlcg7v1nf1mpq";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
  '';
}
