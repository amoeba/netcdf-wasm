# `netcdf-wasm`

**Currently not working** project to work with [NetCDF](https://www.unidata.ucar.edu/software/netcdf/) files in the browser with [WASM](https://webassembly.org/).
Nothing usable at this point.
The ultimate goal is to get a native way to parse metadata out of NetCDF files for use in scientific metadata editors.
This is mostly for my education.

## Pre-requisites

- emscripten
- libnetcdf
- libhdf5
- libzlib

## Building

Note: This is what _I_ run and probably won't work for you. Edit the `-I` flags to point to the right locations.

```
emcc -O3 -s WASM=1 -I /usr/local/Cellar/curl/*/include -I /usr/local/Cellar/hdf5/*/include -I /usr/local/Cellar/netcdf/*/include src/main.c
```

## Status

The build current fails. I'm not sure why:

```
; emcc -O3 -s WASM=1 -I /usr/local/Cellar/curl/*/include -I /usr/local/Cellar/hdf5/*/include -I /usr/local/Cellar/netcdf/*/include src/main.c
error: undefined symbol: nc_create (referenced by top-level compiled C/C++ code)
warning: Link with `-s LLD_REPORT_UNDEFINED` to get more information on undefined symbols
warning: To disable errors for undefined symbols use `-s ERROR_ON_UNDEFINED_SYMBOLS=0`
warning: _nc_create may need to be added to EXPORTED_FUNCTIONS if it arrives from a system library
Error: Aborting compilation due to previous errors
emcc: error: '/usr/local/bin/node /usr/local/Cellar/emscripten/2.0.31/libexec/src/compiler.js /var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/tmp4xz2wm2w.txt' failed (returned 1)
```

## TODO

- Figure out how to pass WASM a user-supplied NetCDF file. WASM is heavily sandboxed and I don't want to (1) precompile the NetCDF file in or (2) have to read the entire file. (2) may be unavoidable which sucks.
  - If (2) is the case, it may be possible to only read in _enough_ of the file to get the metadata we need out.
- Get this reading the attribute names from a NetCDF file the user chooses
