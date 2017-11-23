// C++ wrappers to call the off-the-shelf SGP4 functions from C.
#include <sgp4wrapper.h>
#include <sgp4unit_for_c.h>
#include <sgp4io_for_c.h>

extern "C" int sgp4_c(
   gravconsttype whichconst, elsetrec* satrec,  double tsince,
   double r[3],  double v[3]
) {
 (int)sgp4(whichconst, *satrec, tsince, r, v);
}

extern "C" void twoline2rv_c(
  char      longstr1[130], char longstr2[130],
  char      typerun,  char typeinput, char opsmode,
  gravconsttype       whichconst,
  double* startmfe, double* stopmfe, double* deltamin,
  elsetrec* satrec
) {
  twoline2rv(longstr1, longstr2, typerun, typeinput, opsmode, whichconst, *startmfe, *stopmfe, *deltamin, *satrec);
}
