all:
	g++ -Ikiss_fft130 -Ikiss_fft130/tools fft.c kiss_fft130/kiss_fft.c testFFT.cc -o test
