################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/fft.c \
../src/main.c \
../src/oled.c \
../src/platform.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/fft.o \
./src/main.o \
./src/oled.o \
./src/platform.o 

C_DEPS += \
./src/fft.d \
./src/main.d \
./src/oled.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I../../FFT_bsp/ps7_cortexa9_0/include -I"/home/bill/workspace/EmbeddedSystemDesign/FPGAFFT/Xilinx/FFT/src/kiss_fft130" -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


