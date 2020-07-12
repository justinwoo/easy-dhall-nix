{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-lsp-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchzip {
    url = release.dhall-lsp-server-darwin.url;
    sha256 = release.dhall-lsp-server-darwin.hash;
  }
  else pkgs.fetchzip {
    url = release.dhall-lsp-server-linux.url;
    sha256 = release.dhall-lsp-server-linux.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_LSP=$out/bin/dhall-lsp-server
    install -D -m555 -T dhall-lsp-server $DHALL_LSP

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_LSP --bash-completion-script $DHALL_LSP > $out/etc/bash_completion.d/dhall-lsp-server-completion.bash
  '';
}
