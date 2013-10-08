#include <stdint.h>
#include <stdio.h>
#include "platform.h"
#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <math.h>
#include "kiss_fft130/kiss_fft.h"
#include "oled.h"
#ifndef M_PI
#define M_PI 3.14159265358979324
#endif

#define timer_base 0xf8f00000
/***********************************************************
Timer Registers
************************************************************/
static volatile int *timer_counter_l=(volatile int *)(timer_base+0x200);
static volatile int *timer_counter_h=(volatile int *)(timer_base+0x204);
static volatile int *timer_ctrl=(volatile int *)(timer_base+0x208);
/***********************************************************
Performance Measurement Functions definitions
************************************************************/
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

#define N 128
#define WINDOW 4
void FFT(const kiss_fft_cpx in[N], kiss_fft_cpx out[N])
{
    kiss_fft_cfg cfg;

    if ((cfg = kiss_fft_alloc(N, 0/*is_inverse_fft*/, NULL, NULL)) != NULL)
    {
        kiss_fft(cfg, in, out);
        free(cfg);
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
    int outLED[N];
    size_t i, j, window;
    int timerL=0;
    print("start");

    Xil_Out32(OLED_BASE_ADDR,0xff);
	OLED_Init();
	//OLED_ShowString(0,0, "Hello FFT!");
	OLED_Refresh_Gram();
	while(1){
		OLED_Clear();
		init_timer(timer_ctrl, timer_counter_l, timer_counter_h);
		start_timer(timer_ctrl);

		for(window = 0; window < WINDOW; ++window)
		{
			//Generating result
			for (i = 0; i < N; i++)
				in[i].r = ((float)(rand()%128))/128.0f, in[i].i = 0;

			//FFT
			timerL = *timer_counter_l;
			FFT(in, out);
			printf("FFT timer_counter_l change:%d\n",*timer_counter_l-timerL);

			outLED[i] = 0;

			//get absolute value and sum
			timerL = *timer_counter_l;
			for (i = 0; i < N; i++)
			{
				int conj_out =sqrt((out[i].r*out[i].r) + (out[i].i*out[i].i));
				outLED[i]+=conj_out;
			}
			printf("Step2 timer_counter_l change:%d\n",*timer_counter_l-timerL);
		}

		//Averaging
		timerL = *timer_counter_l;
		for(i=0; i<N; ++i)
		{
			outLED[i]=outLED[i]>>2;
		}
		printf("Averaging timer_counter_l change:%d\n",*timer_counter_l-timerL);

		//print
		for(i=0; i<N; ++i)
		{
			printf("out[%d]= %d\n",i,outLED[i]);
		}

		//Display
		timerL = *timer_counter_l;
		for(i=0; i<N; ++i)
		{
			for(j=0; j< outLED[i]; ++j)
				OLED_DrawPoint(i,63-j,1);
		}
		OLED_Refresh_Gram();
		printf("Display timer_counter_l change:%d\n",*timer_counter_l-timerL);
		stop_timer(timer_ctrl);
	}
    return 0;
}
