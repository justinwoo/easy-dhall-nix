#!/usr/bin/env sh
set -e
test_script="$(nix-build ./test.nix)"
exec "$test_script"
