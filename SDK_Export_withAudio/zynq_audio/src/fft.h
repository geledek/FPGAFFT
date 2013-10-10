/************************************************************************
	fft.h

    FFT Audio Analysis
    Copyright (C) 2011 Simon Inns

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

	Email: simon.inns@gmail.com

************************************************************************/
//Modified By Shipeng Xu
//Email:      sxu008@e.ntu.edu.sg
//float version from
//http://www-ee.uta.edu/eeweb/ip/Courses/DSP_new/Programs/fft.cpp
#ifndef _FIXED_FFT_H
#define _FIXED_FFT_H

#ifndef M_PI
#define M_PI 3.14159265358979324
#endif

#define PI	M_PI	/* pi to machine precision, defined in math.h */
#define TWOPI	(2.0*PI)

// Function prototypes
void fix_fft(short fr[], short fi[], short m);
void fft(float data[], int nn, int isign);
#endif 
