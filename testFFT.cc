#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#ifndef M_PI
#define M_PI 3.14159265358979324
#endif
#include "fft.h"
#define N 128
#define POW_N 7
int main(void)
{
    short real[128];
    short image[128];
    for(int i=0; i<128; ++i)
    {
        real[i] = cos(2 * M_PI * 4 * i / N)*(1<<14);
        printf("real[%d]= %d \n",i, real[i]);
    }
    fix_fft(real,image,POW_N);
    for(int i=0; i<128; ++i)
    {
        printf("real[%d]= %d  image[%d]= %d\n",i, real[i],i,image[i]);
    }
    return 0;
}
