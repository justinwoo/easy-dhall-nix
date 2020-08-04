{ pkgs, release }:

{ simpleName, binName, attrName }:

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

  nativeBuildInputs = [ pkgs.installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    binPath="$out/bin/${binName}"
    install -D -m555 -T ${binName} "$binPath"

    "$binPath" --bash-completion-script "$binPath" > "${binName}.bash"
    installShellCompletion --bash "${binName}.bash"
    "$binPath" --zsh-completion-script "$binPath" > "${binName}.zsh"
    installShellCompletion --zsh "${binName}.zsh"
    "$binPath" --fish-completion-script "$binPath" > "${binName}.fish"
    installShellCompletion --fish "${binName}.fish"
  '';
}
