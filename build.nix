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
    install -D -m555 -T "${binName}" "$binPath"
    rm "${binName}"

    # check that we didn’t forget any files (maybe a new binary was added)
    if [ ! -z "$(${pkgs.lr}/bin/lr -1 -t 'depth == 1' .)" ]; then
      echo "still some files remaining!" >&2
      ${pkgs.lr}/bin/lr .
      exit 1
    fi

    "$binPath" --bash-completion-script "$binPath" > "${binName}.bash"
    installShellCompletion --bash "${binName}.bash"
    "$binPath" --zsh-completion-script "$binPath" > "${binName}.zsh"
    installShellCompletion --zsh "${binName}.zsh"
    "$binPath" --fish-completion-script "$binPath" > "${binName}.fish"
    installShellCompletion --fish "${binName}.fish"
  '';
}
