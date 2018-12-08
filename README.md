# Easy Dhall Nix

[![Build Status](https://travis-ci.org/justinwoo/easy-dhall-nix.svg?branch=master)](https://travis-ci.org/justinwoo/easy-dhall-nix)

Derivations for easily downloading Nix binaries and putting them to use.

## Trial

You cn get an appropriate nix-shell with the binaries installed by first testing this with:

```
nix-shell -A shell
```

## Installation

You might choose to simply copy the derivations from this repository, or you can fetch the git/Github repo using the various helpers:

```nix
> nix repl
nix-repl> pkgs = import <nixpkgs> {}

nix-repl> drvs = import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = "87406a76409c16bbd7511e397cfc52e1c58954e3";
  sha256 = "1sjpckyhvlks5yls0qqfd0iaf7pxp1sp3dikqh41lg6xsxx6lqhi";
}) {}

nix-repl> drvs.dhall-simple
«derivation /nix/store/qz29jbplpmlvsbmq05084dh1fbs8sl0h-dhall-simple.drv»
```

## NixOS: Contributors needed

If you want to use this in NixOS, then please supply some PRs for the appropriate patchelf voodoo.
