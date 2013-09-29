/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"

void print(char *str);

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "kiss_fft130/kiss_fft.h"

#ifndef M_PI
#define M_PI 3.14159265358979324
#endif

#define N 128

void TestFft(const char* title, const kiss_fft_cpx in[N], kiss_fft_cpx out[N])
{
    kiss_fft_cfg cfg;

    printf("%s\n", title);

    if ((cfg = kiss_fft_alloc(N, 0/*is_inverse_fft*/, NULL, NULL)) != NULL)
    {
        size_t i;

        kiss_fft(cfg, in, out);
        free(cfg);

        for (i = 0; i < N; i++)
            printf(" in[%2zu] = %+f , %+f    "
                    "out[%2zu] = %+f , %+f\n",
                    i, in[i].r, in[i].i,
                    i, out[i].r, out[i].i);
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
    size_t i;
    print("start");

    for (i = 0; i < N; i++)
        in[i].r = in[i].i = 0;
    TestFft("Zeroes (complex)", in, out);

    for (i = 0; i < N; i++)
        in[i].r = 1, in[i].i = 0;
    TestFft("Ones (complex)", in, out);

    for (i = 0; i < N; i++)
        in[i].r = cos(2 * M_PI * 4 * i / N), in[i].i = 0;
    TestFft("SineWave (complex)", in, out);

    return 0;
}
