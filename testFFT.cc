#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define FIXED_POINT 32 
#include "kiss_fft.h"

#ifndef M_PI
//#define M_PI 3.14159265358979324
#endif

#define N 128

void TestFft(const char* title, const kiss_fft_cpx in[N], kiss_fft_cpx out[N])
{
    kiss_fft_cfg cfg;
    float acc_conj_pdt_out=0, conj_pdt_out[N];

    printf("%s\n", title);

    if ((cfg = kiss_fft_alloc(N, 0/*is_inverse_fft*/, NULL, NULL)) != NULL)
    {
        int i;

        kiss_fft(cfg, in, out);
        free(cfg);

        for (i = 0; i < N; i++)
        {
         
            conj_pdt_out[i]=(out[i].r*out[i].r) + (out[i].i*out[i].i); //product of conjugate-multiplication
            acc_conj_pdt_out+=conj_pdt_out[i]; 
            printf(" in[%d] = %f , %f    "
                    "out[%d] = %f , %f   "
                    "conj_pdt_out[%d] = %f\n",
                    i, in[i].r, in[i].i,
                    i, out[i].r, out[i].i,
                    i, conj_pdt_out[i]);
           
        }
   
         float avg_conj_pdt_out=acc_conj_pdt_out/N;
         printf("avg_conj_pdt_out= %f \n", avg_conj_pdt_out); //display result after taking the average of 'product of conjugates'
     
    }
    else
    {
        printf("not enough memory?\n");
        exit(-1);
    }
}

int main(void)
{
    kiss_fft_cpx in[N], out[N];
    int i;
    for (i = 0; i < N; i++)
        in[i].r =((short)(cos(2 * M_PI * 4 * i / N)*(1<<8))), in[i].i = 0;
    TestFft("SineWave (complex)", in, out);

    return 0;
}
