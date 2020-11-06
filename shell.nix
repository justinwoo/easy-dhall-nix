let
  pkgs = import ./nixpkgs.nix {};

  default = import ./default.nix {
    inherit pkgs;
  };

in
  with default; pkgs.mkShell {
    buildInputs = [
      dhall-simple
      dhall-json-simple
      dhall-bash-simple
      dhall-nix-simple
      dhall-yaml-simple
      dhall-lsp-simple
      dhall-docs-simple
    ];
  }
