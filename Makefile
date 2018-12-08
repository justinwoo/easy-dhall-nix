default: test

test:
	nix-shell -A shell --pure --run './test.bash'
