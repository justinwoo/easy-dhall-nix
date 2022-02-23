{ pkgs ? import ./nixpkgs.nix { } }:

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

  dhall-docs-simple = import ./dhall-docs-simple.nix {
    inherit pkgs;
  };

  dhall-csv-simple = import ./dhall-csv-simple.nix {
    inherit pkgs;
  };

  dhall-toml-simple = import ./dhall-toml-simple.nix {
    inherit pkgs;
  };
}
