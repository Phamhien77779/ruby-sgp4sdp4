#ifndef _sgp4ext_for_c_
#define _sgp4ext_for_c_

void    invjday
        (
          double jd,
          int& year, int& mon, int& day,
          int& hr, int& minute, double& sec
        );

void    rv2coe
        (
          double r[3], double v[3], double mu,
          double& p, double& a, double& ecc, double& incl, double& omega, double& argp,
          double& nu, double& m, double& arglat, double& truelon, double& lonper
        );

#endif
