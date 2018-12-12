{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";
  version = "1.2.5";
  dhall-version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall-version}/dhall-json-${version}-x86_64-linux.tar.bz2";
    sha256 = "0h896bs7r8bxxagzfivxiyk2h4aym7lw7sk7yc4kxh0fr5dzk03g";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    DHALL_TO_YAML=$out/bin/dhall-to-yaml
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON
    install -D -m555 -T dhall-to-yaml $DHALL_TO_YAML

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
  '';
}
