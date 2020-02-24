#include <stdlib.h>
#include <stdio.h>
#include <netcdf.h>

#include "emscripten.h"

EMSCRIPTEN_KEEPALIVE
int main() {
  int ncid;
  int retval;

  // Just check symbols from netcdf.h work...
  NC_INT;

  // Try nc_create for now for testing/debuggin
  retval = nc_create("simple_xy.nc", NC_CLOBBER, &ncid);

  return retval;
}
