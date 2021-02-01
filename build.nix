{ pkgs, release }:

{ simpleName, binNames, attrName, manPages ? [] }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = simpleName;

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = release.${"${attrName}-darwin"}.url;
    sha256 = release.${"${attrName}-darwin"}.hash;
  }
  else pkgs.fetchurl {
    url = release.${"${attrName}-linux"}.url;
    sha256 = release.${"${attrName}-linux"}.hash;
  };

  nativeBuildInputs = [ pkgs.installShellFiles ];

  passthru.binNames = binNames;

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin

    ${pkgs.lib.concatMapStringsSep "\n" (binName: ''
        binPath="$out/bin/${binName}"
        install -D -m555 -T "bin/${binName}" "$binPath"
        rm "bin/${binName}"

        "$binPath" --bash-completion-script "$binPath" > "${binName}.bash"
        installShellCompletion --bash "${binName}.bash"
        rm "${binName}.bash"
        "$binPath" --zsh-completion-script "$binPath" > "${binName}.zsh"
        installShellCompletion --zsh "${binName}.zsh"
        rm "${binName}.zsh"
        "$binPath" --fish-completion-script "$binPath" > "${binName}.fish"
        installShellCompletion --fish "${binName}.fish"
        rm "${binName}.fish"
      '') binNames}

    rmdir bin

    # https://github.com/dhall-lang/dhall-haskell/issues/2161
    rm share/man/dhall-docs.1 \
       share/man/dhall-docs.md \
       share/man/gen-manpage.sh \
       && rmdir share/man && rmdir share \
       || true
    rm share/man/dhall.1 \
       share/man/dhall.md \
       && rmdir share/man && rmdir share \
       || true
    ${pkgs.lib.optionalString (manPages != []) ''
        ${pkgs.lib.concatMapStringsSep "\n" (manPage: ''
          # TODO: split into $man output
          manPagePath="$out/share/man/man1/${manPage}"
          install -D -m644 -T "share/man/man1/${manPage}" "$manPagePath"
          rm "share/man/man1/${manPage}"
        '') manPages}
        rmdir --parent share/man/man1
     ''}

    # a bit hacky, but sourceRoot unfortunately unpacks to the runtime build dir
    rm env-vars .sandbox.sb || true

    # check that we didn’t forget any files (maybe a new binary was added)
    if [ ! -z "$(${pkgs.lr}/bin/lr -1 -t 'depth == 1' .)" ]; then
      echo "still some files remaining!" >&2
      ${pkgs.lr}/bin/lr .
      exit 1
    fi

  '';
}
