{ pkgs, release }:

{ simpleName, binName, attrName, completionName ? binName }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = simpleName;

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchzip {
    url = release.${"${attrName}-darwin"}.url;
    sha256 = release.${"${attrName}-darwin"}.hash;
  }
  else pkgs.fetchzip {
    url = release.${"${attrName}-linux"}.url;
    sha256 = release.${"${attrName}-linux"}.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    binPath="$out/bin/${binName}"
    install -D -m555 -T ${binName} "$binPath"

    mkdir -p $out/etc/bash_completion.d/
    "$binPath" --bash-completion-script "$binPath" > "$out/etc/bash_completion.d/${completionName}-completion.bash"
  '';
}
