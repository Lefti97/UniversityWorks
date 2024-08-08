function [B, C]=butterworth_filter(A, dt,N,fc,f0);
% B=butterworth_filter(A, dt,N,fc,f0);
% B: output of the filter 
% A:  input signal to be filtered
% dt:  smaller time particle
% N: filter order (1-12) the higher the order the more ideal the filter
% fc: cutoff frequency
% f0:  central frequency of the filter






samples=length(A);
j=-(samples/2):1:(samples/2)-1;
f=j*(1/samples);
f=f/dt;
Hpar=1+i*(((f-f0)/fc).^N);
H=Hpar.^(-1);
A=fft(A);
A=fftshift(A);
A=H.*A;
C=A;%%%%%%%%%%%%%%%
A=ifftshift(A);
A=ifft(A);
B=A;
