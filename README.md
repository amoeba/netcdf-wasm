# `netcdf-wasm`

WIP project to work with [NetCDF ](https://www.unidata.ucar.edu/software/netcdf/) files in the browser with [WASM](https://webassembly.org/).
Nothing usable at this point.
The ultimate goal is to get a native way to parse metadata out of NetCDF files for use in scientific metadata editors.
This is opposed to using a JavaScript implementation which may or may not work as well as the standard C library.

## Setup

1. Set up Emscripten. I strongly recommend
   [the official docs](https://emscripten.org/docs/getting_started/downloads.html).

2. Grab the NetCDF C library:

   ```sh
   git clone https://github.com/Unidata/netcdf-c
   ```

   i.e., you should have a `netcdf-c` directory under the root of your checkout of this repo before moving on with subfolders like `include`.

3. Build this:

   ```sh
   sh build.sh
   ```

4. Serve index.html with a web server. [devd](https://github.com/cortesi/devd) is a really good choice:

   ```sh
   devd . -o
   ```

## Status

I'm stuck on:

> \$ emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -I /usr/local/Cellar/netcdf/4.7.3_1/include src/main.c -s LLD_REPORT_UNDEFINED
> wasm-ld: error: /var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/emscripten_temp_C9kBHW/main_0.o: **undefined symbol: nc_create**
> shared:ERROR: '/Users/bryce/src/emsdk/upstream/bin/wasm-ld -o /var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/emscripten_temp_C9kBHW/a.out.wasm --lto-O0 /var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/emscripten_temp_C9kBHW/main_0.o -L/Users/bryce/src/emsdk/upstream/emscripten/system/local/lib -L/Users/bryce/src/emsdk/upstream/emscripten/system/lib -L/Users/bryce/.emscripten_cache/wasm-obj /Users/bryce/.emscripten_cache/wasm-obj/libc.a /Users/bryce/.emscripten_cache/wasm-obj/libcompiler_rt.a /Users/bryce/.emscripten_cache/wasm-obj/libc-wasm.a /Users/bryce/.emscripten_cache/wasm-obj/libdlmalloc.a /Users/bryce/.emscripten_cache/wasm-obj/libpthread_stub.a /Users/bryce/.emscripten_cache/wasm-obj/libc_rt_wasm.a /Users/bryce/.emscripten_cache/wasm-obj/libsockets.a --allow-undefined-file=/var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/tmp4SEVzz.undefined --import-memory --import-table -mllvm -combiner-global-alias-analysis=false -mllvm -enable-emscripten-sjlj -mllvm -disable-lsr --strip-debug --export **wasm_call_ctors --export **data_end --export main --export \_\_errno_location -z stack-size=5242880 --initial-memory=16777216 --no-entry --max-memory=16777216 --global-base=1024' failed (1)

Things are hopefully hooked up correctly because I get compiler errors if, for example, I have an invalid type signature on a call to `nc_create`.
But, once fixed, I get "undefined symbol" on any external symbols defined in `netcdf.h`.

My hunch right now is that this is because the implementation of any `netcdf-c` API functions are not where I expected. i.e., I can't find a function body for `nc_create`. Is it actually located where I see `NC_create` in `ncdispatch.h` and `netcdf-c`s compilation processs automatically maps these so the generated DLLS work?

## TODO

- Figure out how to pass WASM a user-supplied NetCDF file. WASM is heavily sandboxed and I don't want to (1) precompile the NetCDF file in or (2) have to read the entire file. (2) may be unavoidable which sucks.
  - If (2) is the case, it may be possible to only read in _enough_ of the file to get the metadata we need out.
- Get this reading the attribute names from a NetCDF file the user chooses

```

```
