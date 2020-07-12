#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3 curl nix

import json
import re
import subprocess as sub
import sys

# fetch the release info from releases/latest
def curl_latest_release():
    url = "https://api.github.com/repos/dhall-lang/dhall-haskell/releases/latest"
    return json.loads(sub.check_output(["curl", url]))

# call nix-prefetch-url on each asset to get their hashes
def prefetch_binaries(release):
    res = []
    for a in release['assets']:
        if "linux" in a['name'] or "macos" in a['name']:
            print(a['name'], file=sys.stderr)
            hash = sub.check_output([
                "nix-prefetch-url", '--unpack', a['browser_download_url']
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
    release = curl_latest_release()
    version = release['tag_name']
    print("updating to release {}".format(version), file=sys.stderr)
    fetched = prefetch_binaries(release)
    res = postprocess(fetched)
    print("writing ./release.json", file=sys.stderr)
    with open("./release.json", mode='w') as f:
        json.dump(res, f, indent=2)
