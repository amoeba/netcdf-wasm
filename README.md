# `netcdf-wasm`

WIP project to work with [NetCDF ](https://www.unidata.ucar.edu/software/netcdf/) files in the browser with [WASM](https://webassembly.org/).
Nothing usable at this point.
The ultimate goal is to get a native way to parse metadata out of NetCDF files for use in scientific metadata editors.
This is opposed to using a JavaScript implementation which may or may not work as well as the standard C library.

## Setup

0. Set up Emscripten. I strongly recommend
   [the official docs](https://emscripten.org/docs/getting_started/downloads.html).

1. Grab the NetCDF C library:

   ```sh
   git clone https://github.com/Unidata/netcdf-c
   ```

   i.e., you should have a `netcdf-c` directory under the root of your checkout of this repo before moving on with subfolders like `include`.

1. Build this:

   ```sh
   sh build.sh
   ```

## TODO

- Figure out how to pass WASM a user-supplied NetCDF file. WASM is heavily sandboxed and I don't want to (1) precompile the NetCDF file in or (2) have to read the entire file. (2) may be unavoidable which sucks.
  - If (2) is the case, it may be possible to only read in _enough_ of the file to get the metadata we need out.
- Get this reading the attribute names from a NetCDF file the user chooses
