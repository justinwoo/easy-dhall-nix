{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import ./default.nix {
    inherit pkgs;
  };

in pkgs.stdenv.mkDerivation {
  name = "easy-dhall-nix-shell";

  buildInputs = [
    easy-dhall.dhall-simple
    easy-dhall.dhall-json-simple
    easy-dhall.dhall-bash-simple
  ];
}
