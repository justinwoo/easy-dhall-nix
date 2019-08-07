{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-json-1.4.0-x86_64-macos.tar.bz2";
      sha256 = "0427xy59mzyrz978l36x0ha610bpckg14m3svkvg8hipvblgh19r";
    }
    else pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-json-1.4.0-x86_64-linux.tar.bz2";
      sha256 = "14apqq0dj3lmm8yccygf8bb27scxjfkjkmr8zgnwb98znr51gfwn";
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
