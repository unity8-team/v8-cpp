#!/bin/bash

DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

cd $DIR

if ! [ -d "depot_tools" ]; then
    git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi

if ! [ -d "v8" ]; then
    git clone --depth 1 --branch 3.28.73 https://chromium.googlesource.com/v8/v8.git
fi

export PATH=./depot_tools:"$PATH"
gclient config --spec 'solutions = [
  { "name"        : "v8",
    "url"         : "https://chromium.googlesource.com/v8/v8.git",
    "deps_file"   : "DEPS",
    "managed"     : False,
    "custom_deps" : {
    },
    "safesync_url": "",
  },
]
cache_dir = None'
gclient sync

cd v8
make -j3 native i18nsupport=off