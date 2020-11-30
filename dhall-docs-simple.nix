{ pkgs ? import ./nixpkgs.nix { } }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-docs-simple";
  binNames = [ "dhall-docs" ];
  attrName = "dhall-docs";
  # see https://github.com/dhall-lang/dhall-haskell/issues/2104
  manPages = if pkgs.stdenv.isDarwin then [ "dhall-docs.1" ] else [];
}
