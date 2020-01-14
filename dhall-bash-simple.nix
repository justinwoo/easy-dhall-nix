{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-bash-1.0.27-x86_64-macos.tar.bz2";
    sha256 = "1zi37x1ifl0qxd7lby72snkf5mmg1xaclm7v815grdvjs08dg4vb";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-bash-1.0.27-x86_64-linux.tar.bz2";
    sha256 = "0rbj42dgsms7074zqsnf6fs0l000mw4ah87ng9411ysaaf3fn35b";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
