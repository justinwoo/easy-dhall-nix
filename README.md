# Easy Dhall Nix

[![Build Status](https://travis-ci.org/justinwoo/easy-dhall-nix.svg?branch=master)](https://travis-ci.org/justinwoo/easy-dhall-nix)

Derivations for easily downloading Dhall binaries and putting them to use.

## Trial

You cn get an appropriate nix-shell with the binaries installed by first testing this with:

```
nix-shell
```

## Installation

You might choose to simply copy the derivations from this repository, or you can fetch the git/Github repo using the various helpers:

```
> nix repl
nix-repl> pkgs = import <nixpkgs> {}

nix-repl> drvs = import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = # some REV
  sha256 = # some SHA
}) {}

nix-repl> drvs.dhall-simple
«derivation /nix/store/qz29jbplpmlvsbmq05084dh1fbs8sl0h-dhall-simple.drv»
```

## NixOS: Contributors needed

If you want to use this in NixOS, then please supply some PRs for the appropriate patchelf voodoo.
