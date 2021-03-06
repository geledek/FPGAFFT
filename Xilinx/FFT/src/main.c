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
#include <stdint.h>
#include <stdio.h>
#include "platform.h"
#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <math.h>
#include "fft.h"
#include "oled.h"


#define N 128
#define POW_N 7
#define WINDOW 4

#define timer_base 0xf8f00000
/***********************************************************
Timer Registers
************************************************************/
static volatile int *timer_counter_l=(volatile int *)(timer_base+0x200);
static volatile int *timer_counter_h=(volatile int *)(timer_base+0x204);
static volatile int *timer_ctrl=(volatile int *)(timer_base+0x208);

void init_timer(volatile int *timer_ctrl, volatile int *timer_counter_l, volatile int *timer_counter_h){
	*timer_ctrl=0x0;
	*timer_counter_l=0x1;
	*timer_counter_h=0x0;
	DATA_SYNC;
}

void start_timer(volatile int *timer_ctrl){
	*timer_ctrl=*timer_ctrl | 0x00000001;
	DATA_SYNC;
}

void stop_timer(volatile int *timer_ctrl){
	*timer_ctrl=*timer_ctrl & 0xFFFFFFFE;
	DATA_SYNC;
}

//#define FIX_POINT


int main(void)
{
    short real[N], image[N];
    float datacpx[N];
    int outLED[N];
    int i,j,window;
    int timeL;
    print("FFT start\n");

    Xil_Out32(OLED_BASE_ADDR,0xff);
	OLED_Init();
	OLED_ShowString(0,0, "Hello FFT!");
	OLED_Refresh_Gram();
	//srand(time(0));
	
	while(1){
		init_timer(timer_ctrl, timer_counter_l, timer_counter_h);
		start_timer(timer_ctrl);
		OLED_Clear();
		for (i = 0; i < N; i++) outLED[i] = 0;
		for(window = 0; window<WINDOW; ++window)
		{
			//Generate input data
			for (i = 0; i < N; i++)
			{
#ifdef FIX_POINT
				real[i] = ((rand()%128-64)/128.0f)*(1<<14);
				image[i] = 0;
#else
				//datacpx[2*i]=(cos(2 * M_PI * 4 * i / N));
				datacpx[2*i]=(rand()%128-64)/128.0f;
				datacpx[2*i+1] = 0;
#endif
			}
			timeL = *timer_counter_l;
			//FFT
#ifdef FIX_POINT
			fix_fft(real, image, POW_N);
#else
			fft(datacpx,N,1);
#endif
			printf("FFT: %d us\n",(*timer_counter_l - timeL)/333);

			timeL = *timer_counter_l;
			//Conj
			for (i = 0; i < N; i++)
			{
#ifdef FIX_POINT
				//printf("real[%d]= %d image[%d]= %d\n",i,real[i],i,image[i]);
				int conj_pdt_out =sqrt((real[i]*real[i]) + (image[i]*image[i]));
#else
				int conj_pdt_out =sqrt((datacpx[2*i]*datacpx[2*i]) + (datacpx[2*i+1]*datacpx[2*i+1]));
#endif
				//conj_pdt_out=conj_pdt_out/2;
				outLED[i]+=conj_pdt_out;
			}
			printf("Conj: %d us\n",(*timer_counter_l - timeL)/333);
		}
		timeL = *timer_counter_l;
		//Averaging
		for(i=0;i<N;++i)
		{
#ifdef FIX_POINT
			outLED[i]=outLED[i]>>10;
#else
			outLED[i]=outLED[i]/8;
#endif
		}
		printf("Averaging: %d us\n",(*timer_counter_l - timeL)/333);
		stop_timer(timer_ctrl);

		//Display
		for(i=0;i<N;++i)
		{
			//printf("real[%d]= %d image[%d]= %d\n",i,real[i],i,image[i]);
			for(j=0; j< outLED[i]; ++j)
				OLED_DrawPoint(i,63-j,1);
		}
		OLED_Refresh_Gram();
	}
    return 0;
}
