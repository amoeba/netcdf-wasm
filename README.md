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

Where does `NCU_OK` come from?

```
❯ emcc -O3 -s WASM=1 -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -I /usr/local/Cellar/curl/7.68.0/include -I netcdf-c/include src/main.c -I netcdf-c netcdf-c/libdispatch/*.c
netcdf-c/libdispatch/durlmodel.c:140:33: error: use of undeclared identifier
      'NCU_OK'
    if(ncuriparse(path,&uri) == NCU_OK) {
                                ^
netcdf-c/libdispatch/durlmodel.c:177:33: error: use of undeclared identifier
      'NCU_OK'
    if(ncuriparse(path,&url) != NCU_OK)
                                ^
netcdf-c/libdispatch/durlmodel.c:261:34: error: use of undeclared identifier
      'NCU_OK'
    if(ncuriparse(path,&tmpurl)==NCU_OK) {
                                 ^
3 errors generated.
shared:ERROR: '/Users/bryce/src/emsdk/upstream/bin/clang -target wasm32-unknown-emscripten -D__EMSCRIPTEN_major__=1 -D__EMSCRIPTEN_minor__=39 -D__EMSCRIPTEN_tiny__=8 -D_LIBCPP_ABI_VERSION=2 -Dunix -D__unix -D__unix__ -Werror=implicit-function-declaration -Xclang -nostdsysteminc -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/include/libcxx -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/lib/libcxxabi/include -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/include/compat -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/include -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/include/libc -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/lib/libc/musl/arch/emscripten -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/local/include -Xclang -isystem/Users/bryce/.emscripten_cache/wasm-obj/include -O3 -I/usr/local/Cellar/curl/7.68.0/include -Inetcdf-c/include -Inetcdf-c -DEMSCRIPTEN netcdf-c/libdispatch/durlmodel.c -Xclang -isystem/Users/bryce/src/emsdk/upstream/emscripten/system/include/SDL -c -o /var/folders/jy/zkmn3bgj13710pnytbgh27800000gn/T/emscripten_temp_xwBoLv/durlmodel_30.o -mllvm -combiner-global-alias-analysis=false -mllvm -enable-emscripten-sjlj -mllvm -disable-lsr' failed (1)
```

## TODO

- Figure out how to pass WASM a user-supplied NetCDF file. WASM is heavily sandboxed and I don't want to (1) precompile the NetCDF file in or (2) have to read the entire file. (2) may be unavoidable which sucks.
  - If (2) is the case, it may be possible to only read in _enough_ of the file to get the metadata we need out.
- Get this reading the attribute names from a NetCDF file the user chooses

```

```
