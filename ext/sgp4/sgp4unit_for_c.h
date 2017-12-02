#ifndef _sgp4unit_for_c_
#define _sgp4unit_for_c_

#include <sgp4types.h>

void getgravconst
     (
      gravconsttype whichconst,
      double& tumin,
      double& mu,
      double& radiusearthkm,
      double& xke,
      double& j2,
      double& j3,
      double& j4,
      double& j3oj2
     );

bool sgp4
     (
       gravconsttype whichconst, elsetrec& satrec,  double tsince,
       double r[3],  double v[3]
     );

#endif
