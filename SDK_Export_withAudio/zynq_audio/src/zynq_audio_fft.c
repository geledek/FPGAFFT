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
#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <math.h>
#include "fft.h"
#include "audio.h"
#include "oled.h"
#include "sleep.h"
#include "xtime_l.h"
#include "xpm_counter.h"
#include "xparameters.h"

#define N 128
#define POW_N 7
#define WINDOW 8

#define FIX_POINT


int main(void)
{
    short real[N], image[N];
    float datacpx[N];
    int outLED[N];
    Xint16 audio_data[128];
    int i,j,window;
    XTime tEnd, tCur;
    u32 tUsed;
    int cycle=0;
    print("FFT start\n");


    u8 *oled_equalizer_buf=(u8 *)malloc(128*sizeof(u8));
	Xil_Out32(OLED_BASE_ADDR,0xff);
	OLED_Init();			//oled init
	IicConfig(XPAR_XIICPS_0_DEVICE_ID);
	AudioPllConfig(); //enable core clock for ADAU1761
	AudioConfigure();

	xil_printf("ADAU1761 configured\n\r");

	//srand(time(0));
	while(1){
		OLED_Clear();
		printf("Cycle %d##############################\n",++cycle);
		for (i = 0; i < N; i++) outLED[i] = 0;
		for(window = 0; window<WINDOW; ++window)
		{
			//Generate input data
			XTime_GetTime(&tCur);
			get_audio(audio_data);

			for (i = 0; i < N; i++)
			{
#ifdef FIX_POINT
				//real[i] = ((rand()%128-64)/128.0f)*(1<<14);
				real[i] = audio_data[i];
				image[i] = 0;
#else
				//datacpx[2*i]=(rand()%128-64)/128.0f;
				datacpx[2*i]=((float)(audio_data[i])/200.0f);
				datacpx[2*i+1] = 0;
#endif
			}

			XTime_GetTime(&tEnd);
			tUsed = ((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
			printf("get input %d us\r\n",tUsed);

			//FFT
			XTime_GetTime(&tCur);
#ifdef FIX_POINT
			fix_fft(real, image, POW_N);
#else
			fft(datacpx,N,1);
#endif
			XTime_GetTime(&tEnd);
			tUsed = ((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
			printf("FFT %d us\r\n",tUsed);

			//Conj
			XTime_GetTime(&tCur);
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
			XTime_GetTime(&tEnd);
			tUsed = ((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
			printf("Conj %d us\r\n",tUsed);
		}

		//Averaging
		XTime_GetTime(&tCur);
		for(i=0;i<N;++i)
		{
#ifdef FIX_POINT
			oled_equalizer_buf[i]=outLED[i]>>2;
#else
			oled_equalizer_buf[i]=outLED[i]/8;
#endif
		}
		XTime_GetTime(&tEnd);
		tUsed = ((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
		printf("Averaging %d us\r\n",tUsed);

		//Display
		XTime_GetTime(&tCur);
		OLED_Equalizer_128(oled_equalizer_buf);
		OLED_Refresh_Gram();
		XTime_GetTime(&tEnd);
		tUsed = ((tEnd-tCur)*1000000)/(COUNTS_PER_SECOND);
		printf("Display %d us\r\n",tUsed);
	}
    return 0;
}
