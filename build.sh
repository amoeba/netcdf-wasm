#!/bin/sh

set -e

if [ ! -d "netcdf-c" ]; then
  echo "Error: You need to clone the NetCDF C libraries first. See README.md. Exiting without building."
  exit 1;
fi

echo "Building..."
emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -I netcdf-c/include src/main.c
echo "Done. Check index.html and a.out.js."
