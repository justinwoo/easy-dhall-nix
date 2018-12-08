{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "easy-dhall-nix-shell";
  buildInputs = builtins.attrValues (import ./default.nix { inherit pkgs; });
}
