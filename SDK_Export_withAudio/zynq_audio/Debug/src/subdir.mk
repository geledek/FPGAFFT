################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/audio.c \
../src/fft.c \
../src/oled.c \
../src/zynq_audio_fft.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/audio.o \
./src/fft.o \
./src/oled.o \
./src/zynq_audio_fft.o 

C_DEPS += \
./src/audio.d \
./src/fft.d \
./src/oled.d \
./src/zynq_audio_fft.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -pg -c -fmessage-length=0 -I../../zynq_audio_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


