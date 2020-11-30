#!/usr/bin/env sh
set -e
tmp="$(mktemp -d)"
trap "rm -r $tmp" EXIT
nix-build \
    --out-link "$tmp"/result \
    ./test.nix
"$tmp/result"
