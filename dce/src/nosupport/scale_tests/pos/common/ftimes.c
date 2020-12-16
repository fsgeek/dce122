
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <fcntl.h>

#include <sys/timeb.h>
#include <sys/stat.h>
#include <sys/types.h>

/************************ Prototypes ************************************/

/*********************************************************************
 *** MAIN
 *********************************************************************/

int main(int argc, char *argv[])
{
    struct timeb api1, api2;
    double api_time=0.0;
    char   *env_pntr;

    ftime(&api1);

    sleep(5);

    ftime(&api2);
fprintf(stderr, "api1.time=[%d] api1.millitm=[%d]\n", api1.time, api1.millitm);
fprintf(stderr, "api2.time=[%d] api2.millitm=[%d]\n", api2.time, api2.millitm);
fprintf(stderr, "api1.timezone=[%d] api2.timezone=[%d]\n", api1.timezone, api2.timezone);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;
fprintf(stderr, "api_time=[%d] \n", api_time);
    if (api1.timezone != api2.timezone)
    {
      api_time -= (float)(api2.timezone-api1.timezone)*60.0;
    }

fprintf(stderr, "api_time=[%d] \n", api_time);
 }

