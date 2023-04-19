#!/usr/bin/env nix-shell
#!nix-shell -I nixpkgs=./nixpkgs.nix -i python3 -p python3 curl nix

import json
import re
import subprocess as sub
import sys

# fetch the release info from releases/latest
def curl_latest_release():
    url = "https://api.github.com/repos/dhall-lang/dhall-haskell/releases/latest"
    return json.loads(sub.check_output(["curl", url]))

# fetch the latest nixos unstable version
def curl_latest_nixos_unstable():
    url = "https://nixos.org/channels/nixos-unstable/git-revision"
    return sub.check_output(["curl", "--location",  url]).strip().decode()

def update_nixpkgs(lockfile_path, new_hash):
    # --unpack produces the hash required by `builtins.fetchTarball`
    github_archive = "https://github.com/NixOS/nixpkgs/archive/{}.tar.gz".format(new_hash)
    hash = sub.check_output([
        "nix-prefetch-url", '--unpack', github_archive
    ]).strip().decode()
    date = sub.check_output([
        "date", "--iso-8601=minutes"
    ]).strip().decode()
    with open(lockfile_path, 'w') as f:
        json.dump({
            "comment": "autogenerated by fetch.py",
            "url": github_archive,
            "sha256": hash,
            "date": date
        }, f, indent=2)


# call nix-prefetch-url on each asset to get their hashes
def prefetch_binaries(release):
    res = []
    for a in release['assets']:
        if "linux" in a['name'] or "macOS" in a['name']:
            print(a['name'], file=sys.stderr)
            hash = sub.check_output([
                "nix-prefetch-url", a['browser_download_url']
            ]).strip().decode()
            res += [{
                'name': a['name'],
                'url': a['browser_download_url'],
                'hash': hash
            }]
    return res

# convert the list of binaries to an object we can address
def postprocess(fetched):
    obj = {}
    for i in fetched:
        # split on the first digit ("dhall-foo-bar-1.2.3")
        name = re.split(r'-\d', i['name'])[0]
        post = "-linux" if "linux" in i['name'] else "-darwin"
        obj[name + post] = i
    return(obj)


if __name__ == "__main__":
    print("updating nixpkgs to latest unstable", file=sys.stderr)
    nixos_hash = curl_latest_nixos_unstable()
    update_nixpkgs("./nixpkgs.json", nixos_hash)

    release = curl_latest_release()
    version = release['tag_name']

    print("updating to release {}".format(version), file=sys.stderr)
    fetched = prefetch_binaries(release)
    res = postprocess(fetched)

    print("writing ./release.json", file=sys.stderr)
    with open("./release.json", mode='w') as f:
        json.dump(res, f, indent=2)
