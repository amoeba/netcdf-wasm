#include <stdlib.h>
#include <stdio.h>
#include <netcdf.h>
#include "emscripten.h"

EMSCRIPTEN_KEEPALIVE
int main() {
  int ncid;
  int retval = nc_open("asdf.cdf", NC_NOWRITE, &ncid);

  return retval;
}
