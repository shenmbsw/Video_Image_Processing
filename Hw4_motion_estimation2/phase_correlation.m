function [ result ] = phase_correlation( img1,img2 )
%PHASE_CORRELATION Summary of this function goes here
%   Detailed explanation goes here

    FFT1 = fft2(img1);
    FFT2 = conj(fft2(img2));
    FFTR = FFT1.*FFT2;
    magFFTR = abs(FFTR)+0.1;
    FFTRN = (FFTR./magFFTR);
    result = ifft2(double(FFTRN));

end

