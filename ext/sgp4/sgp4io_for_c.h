#ifndef _sgp4io_for_c_
#define _sgp4io_for_c_

#include <sgp4types.h>

void twoline2rv
     (
      char      longstr1[130], char longstr2[130],
      char      typerun,  char typeinput, char opsmode,
      gravconsttype       whichconst,
      double& startmfe, double& stopmfe, double& deltamin,
      elsetrec& satrec
     );
#endif
