#ifndef _sgp4unit_for_c_
#define _sgp4unit_for_c_

#include <sgp4types.h>

bool sgp4
     (
       gravconsttype whichconst, elsetrec& satrec,  double tsince,
       double r[3],  double v[3]
     );

#endif
