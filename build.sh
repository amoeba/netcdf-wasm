#!/bin/sh

set -e

if [ ! -d "netcdf-c" ]; then
  echo "Error: You need to clone the NetCDF C libraries first. See README.md. Exiting without building."
  exit 1;
fi

echo "Building..."
emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -I /usr/local/Cellar/curl/7.68.0/include -I netcdf-c/include src/main.c -I netcdf-c netcdf-c/libdispatch/*.c
echo "Done. Check index.html and a.out.js."
