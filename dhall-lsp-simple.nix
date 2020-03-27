{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-lsp-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-lsp-server-1.0.5-x86_64-macos.tar.bz2";
    sha256 = "1ng7f6mrxz1yjwskdf0knlbrb1r8d95yb9sqzbfymnynvpakjn1g";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-lsp-server-1.0.5-x86_64-linux.tar.bz2";
    sha256 = "0bgidy98s6nn2ysfbyl13s36rc8mn1rr5lw2wdpad6achz0mr397";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_LSP=$out/bin/dhall-lsp-server
    install -D -m555 -T dhall-lsp-server $DHALL_LSP

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_LSP --bash-completion-script $DHALL_LSP > $out/etc/bash_completion.d/dhall-lsp-server-completion.bash
  '';
}
