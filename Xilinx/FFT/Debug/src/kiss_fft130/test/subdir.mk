################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/kiss_fft130/test/benchfftw.c \
../src/kiss_fft130/test/benchkiss.c \
../src/kiss_fft130/test/doit.c \
../src/kiss_fft130/test/pstats.c \
../src/kiss_fft130/test/test_real.c \
../src/kiss_fft130/test/test_vs_dft.c \
../src/kiss_fft130/test/twotonetest.c 

OBJS += \
./src/kiss_fft130/test/benchfftw.o \
./src/kiss_fft130/test/benchkiss.o \
./src/kiss_fft130/test/doit.o \
./src/kiss_fft130/test/pstats.o \
./src/kiss_fft130/test/test_real.o \
./src/kiss_fft130/test/test_vs_dft.o \
./src/kiss_fft130/test/twotonetest.o 

C_DEPS += \
./src/kiss_fft130/test/benchfftw.d \
./src/kiss_fft130/test/benchkiss.d \
./src/kiss_fft130/test/doit.d \
./src/kiss_fft130/test/pstats.d \
./src/kiss_fft130/test/test_real.d \
./src/kiss_fft130/test/test_vs_dft.d \
./src/kiss_fft130/test/twotonetest.d 


# Each subdirectory must supply rules for building sources it contributes
src/kiss_fft130/test/%.o: ../src/kiss_fft130/test/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I../../FFT_bsp/ps7_cortexa9_0/include -I"/home/bill/workspace/Xilinx/FFT/src/kiss_fft130" -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


