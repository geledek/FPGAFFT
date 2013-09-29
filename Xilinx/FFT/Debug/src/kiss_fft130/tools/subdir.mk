################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/kiss_fft130/tools/fftutil.c \
../src/kiss_fft130/tools/kfc.c \
../src/kiss_fft130/tools/kiss_fastfir.c \
../src/kiss_fft130/tools/kiss_fftnd.c \
../src/kiss_fft130/tools/kiss_fftndr.c \
../src/kiss_fft130/tools/kiss_fftr.c \
../src/kiss_fft130/tools/psdpng.c 

OBJS += \
./src/kiss_fft130/tools/fftutil.o \
./src/kiss_fft130/tools/kfc.o \
./src/kiss_fft130/tools/kiss_fastfir.o \
./src/kiss_fft130/tools/kiss_fftnd.o \
./src/kiss_fft130/tools/kiss_fftndr.o \
./src/kiss_fft130/tools/kiss_fftr.o \
./src/kiss_fft130/tools/psdpng.o 

C_DEPS += \
./src/kiss_fft130/tools/fftutil.d \
./src/kiss_fft130/tools/kfc.d \
./src/kiss_fft130/tools/kiss_fastfir.d \
./src/kiss_fft130/tools/kiss_fftnd.d \
./src/kiss_fft130/tools/kiss_fftndr.d \
./src/kiss_fft130/tools/kiss_fftr.d \
./src/kiss_fft130/tools/psdpng.d 


# Each subdirectory must supply rules for building sources it contributes
src/kiss_fft130/tools/%.o: ../src/kiss_fft130/tools/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I../../FFT_bsp/ps7_cortexa9_0/include -I"/home/bill/workspace/Xilinx/FFT/src/kiss_fft130" -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


