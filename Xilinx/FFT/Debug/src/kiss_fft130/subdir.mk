################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/kiss_fft130/kiss_fft.c 

OBJS += \
./src/kiss_fft130/kiss_fft.o 

C_DEPS += \
./src/kiss_fft130/kiss_fft.d 


# Each subdirectory must supply rules for building sources it contributes
src/kiss_fft130/%.o: ../src/kiss_fft130/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I../../FFT_bsp/ps7_cortexa9_0/include -I"/home/bill/workspace/EmbeddedSystemDesign/FPGAFFT/Xilinx/FFT/src/kiss_fft130" -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


