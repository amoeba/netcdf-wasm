#include <stdlib.h>
#include <stdio.h>
#include <netcdf.h>
#include "emscripten.h"

EMSCRIPTEN_KEEPALIVE
int main() {
  return NC_MAX_INT;
}
