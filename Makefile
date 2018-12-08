default: test

test:
	nix-shell --pure --run './test.bash'
