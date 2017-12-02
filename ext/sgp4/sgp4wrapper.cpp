// C++ wrappers to call the off-the-shelf SGP4 functions from C.
#include <sgp4wrapper.h>
#include <sgp4unit_for_c.h>
#include <sgp4io_for_c.h>
#include <sgp4ext_for_c.h>

extern "C" void getgravconst_c(
  gravconsttype whichconst,
  double *tumin,
  double *mu,
  double *radiusearthkm,
  double *xke,
  double *j2,
  double *j3,
  double *j4,
  double *j3oj2
) {
  getgravconst(whichconst, *tumin, *mu, *radiusearthkm, *xke, *j2, *j3, *j4, *j3oj2);
}

extern "C" void invjday_c(
  double jd,
  int *year, int *mon, int *day,
  int *hr, int *minute, double *sec
) {
  invjday(jd, *year, *mon, *day, *hr, *minute, *sec);
}

extern "C" void rv2coe_c(
  double r[3], double v[3], double mu,
  double *p, double *a, double *ecc, double *incl, double *omega, double *argp,
  double *nu, double *m, double *arglat, double *truelon, double *lonper
) {
  rv2coe(r, v, mu, *p, *a, *ecc, *incl, *omega, *argp, *nu, *m, *arglat, *truelon, *lonper);
}

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
