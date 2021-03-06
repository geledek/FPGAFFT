/*
 * fft_test.c
 *
 *  Created on: Oct 17, 2013
 *      Author: vipin2
 */
#include "xparameters.h"
#include <stdio.h>
#include "xil_io.h"
#include "xdmaps.h"
#include "xtime_l.h"
#include "xil_cache.h"
#include "oled.h"
#include "audio.h"
XDmaPs DmaInstance;

#define DMA_DEVICE_ID 			XPAR_XDMAPS_1_DEVICE_ID
#define TIMEOUT_LIMIT 	0x2000	/* Loop count for timeout */
#define timer_base 0xF8F00000

int init_DMA (u16 DeviceId, XDmaPs *DmaInst);
int load_Data_dma(u32 src_addr, u32 dst_addr, u32 len, XDmaPs *DmaInst);

/***********************************************************
Timer Registers
************************************************************/
static volatile int *timer_counter_l=(volatile int *)(timer_base+0x200);
static volatile int *timer_counter_h=(volatile int *)(timer_base+0x204);
static volatile int *timer_ctrl=(volatile int *)(timer_base+0x208);
/***********************************************************
/***********************************************************
Function definitions
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

#define DMACHAN
int main(){
	u32 i,j;
	u32 ret[1025];
	u32 rat[1025];
	int Status;
	Xint16 audio_data[128];
	int *mem = XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x20000;
	XDmaPs *DmaInst = &DmaInstance;
	u8 *oled_equalizer_buf=(u8 *)malloc(128*sizeof(u8));
	Xil_Out32(OLED_BASE_ADDR,0xff);
	OLED_Init();
	xil_printf("OLED_Init\n\r");
	IicConfig(XPAR_XIICPS_0_DEVICE_ID);
	AudioPllConfig(); //enable core clock for ADAU1761
	AudioConfigure();

	xil_printf("ADAU1761 configured\n\r");
	//Store some incremental pattern in the DRAM memory
	while(1)
	{
		mem = XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x20000;
		for(i=0;i<4;i++)
		{
			get_audio(audio_data);
			for(j=0;j<128;++j)
			{
				int tmp;
				tmp = audio_data[j]&0x0000FFFF;
				*mem = tmp&0x0000FFFF;
				 mem++;
			}
		}
		//Flush the cache to make sure that data has reached DRAM
		Xil_DCacheFlush();

		mem = XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x20000;
#ifdef DMACHAN
		Status = init_DMA (DMA_DEVICE_ID,DmaInst);
		Status = load_Data_dma(XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x20000, XPAR_FFT_PERIPHERAL_0_S_AXI_MEM0_BASEADDR, 128*4*4, DmaInst);
#else
		for(i=0;i<128*4;i++)
		{
			Xil_Out32(XPAR_FFT_PERIPHERAL_0_S_AXI_MEM0_BASEADDR,*mem);
			mem++;
		}
#endif
		print("Reading data from the core \n\r");
		//Read the output from the core one by one and store in an array and later print it
		for(i=0;i<128;i++)
			ret[i] = Xil_In32(XPAR_FFT_PERIPHERAL_0_S_AXI_MEM0_BASEADDR);
		OLED_Clear();
		for(i=0;i<128;i++)
		{
			if(i<125)oled_equalizer_buf[i+2]=ret[i]>>4;
			else oled_equalizer_buf[i-125]=ret[i]>>4;
		}

		OLED_Equalizer_128(oled_equalizer_buf);
	}
	return 0;
}



/*****************************************************************************/
/*
 * DMA controller initialisation.
 * This is the standard method for initialising the PS DMA controller
 ****************************************************************************/
int init_DMA (u16 DeviceId, XDmaPs *DmaInst)
{
	int Status;
	XDmaPs_Config *DmaCfg;
	/*
	 * Initialize the DMA Driver
	 */
	DmaCfg = XDmaPs_LookupConfig(DeviceId);
	if (DmaCfg == NULL) {
		return XST_FAILURE;
	}

	Status = XDmaPs_CfgInitialize(DmaInst,
				   DmaCfg,
				   DmaCfg->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}


/**********************************************************************
 * Function to send data using the DMA controller
 * inputs  : source address (src_addr), destination address (dst_addr),
 * transfer size in bytes (len), and the DMA controller instance pointer
 * (DmsInst)
 * output  : Transfer status
 *********************************************************************/
int load_Data_dma(u32 src_addr, u32 dst_addr, u32 len, XDmaPs *DmaInst)
{
	unsigned int Channel = 0;
	int Status;

	XDmaPs_Cmd DmaCmd;
	memset(&DmaCmd, 0, sizeof(XDmaPs_Cmd));

	//The DMA command structure
	DmaCmd.ChanCtrl.SrcBurstSize = 4;   //Source burst size. 32-bits = 4 bytes
	DmaCmd.ChanCtrl.SrcBurstLen = 1;    //Source burst length. set to 1
	DmaCmd.ChanCtrl.SrcInc = 1;         //Whether source address should be incremented for each data. Since reading from memory, set to 1
	DmaCmd.ChanCtrl.DstBurstSize = 4;   //Destination burst size
	DmaCmd.ChanCtrl.DstBurstLen = 1;    //Destination burst length
	DmaCmd.ChanCtrl.DstInc = 0;         //Since data is finally going to a stream interface, it doesn't matter whether address increments or not
	DmaCmd.BD.SrcAddr = src_addr;       //Source start address for DMA
	DmaCmd.BD.DstAddr = dst_addr;       //Destination start address for DMA
	DmaCmd.BD.Length = len;             //DMA length in bytes

	//Clear any pending interrupt in the DMA controller
	Xil_Out32(0xF800302C,0xff);
    //Start the DMA controller
	Status = XDmaPs_Start(DmaInst, Channel, &DmaCmd, 0);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
    //Poll the interrupt status register to check whether DMA is over
	while(Xil_In32(0xF8003028) == 0x0)
	{

	}

	return XST_SUCCESS;
}
