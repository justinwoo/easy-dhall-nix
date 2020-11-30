{ pkgs ? import ./nixpkgs.nix {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-simple";
  binNames = [ "dhall" ];
  attrName = "dhall";
  # see https://github.com/dhall-lang/dhall-haskell/issues/2104
  manPages = if pkgs.stdenv.isDarwin then [ "dhall.1" ] else [];
}
