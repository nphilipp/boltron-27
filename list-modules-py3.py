#! /usr/bin/python3

import dnf

base = dnf.Base()
base.read_all_repos()
base.fill_sack()

mods = []

for module in base.repo_module_dict.values():
    for stream in module.values():
        for version in stream.values():
            mods.append((module.name, stream.stream, version.version))

for i in sorted(mods):
    print("%20s %20s %20s" % i)

