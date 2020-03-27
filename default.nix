{ pkgs ? import <nixpkgs> {} }:

{
  dhall-simple = import ./dhall-simple.nix {
    inherit pkgs;
  };

  dhall-json-simple = import ./dhall-json-simple.nix {
    inherit pkgs;
  };

  dhall-bash-simple = import ./dhall-bash-simple.nix {
    inherit pkgs;
  };

  dhall-nix-simple = import ./dhall-nix-simple.nix {
    inherit pkgs;
  };

  dhall-yaml-simple = import ./dhall-yaml-simple.nix {
    inherit pkgs;
  };

  dhall-lsp-simple = import ./dhall-lsp-simple.nix {
    inherit pkgs;
  };
}
