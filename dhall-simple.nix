{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";
  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-1.25.0-x86_64-macos.tar.bz2";
      sha256 = "1ar1wh0kp1fn0xbr60b61bkj4q3bd2k0df6lgzyqngbjackx2yn2";
    }
    else pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-1.25.0-x86_64-linux.tar.bz2";
      sha256 = "12w2549mx4js7dz4qjcrps6nivj37ikg3daybl5fskshdyf44ia7";
    };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
