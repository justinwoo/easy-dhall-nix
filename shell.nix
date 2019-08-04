let
  pkgs = import <nixpkgs> {};
  default = import ./default.nix {};
in
  pkgs.mkShell {
    buildInputs =
      builtins.attrValues default;
  }
