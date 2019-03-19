
clc
clear all
M=2;
k = log2(M);    
i=1% k is number of bits : M = 2^k
 for j = .6:.1:20                 % j is a counter equal to SNR per bit in the range from 0.6 to 20  
        SNR_sym = j*k;                % SNR per symbol equal to SNR per bit multiplied by Number of bits
eval(['v =inline(''(1./(sqrt(2*pi)).*(1-((1-0.5*erfc(t)./sqrt(2))).^(' num2str(M) '-1)).*exp(-.5*(t-sqrt(2*' num2str(SNR_sym) ')).^2))'',''t'');' ]);
 w = quadl(v,-10000,10000,1e-12);
       BER(k,i) = w;                 % Construct probability of error Matrix with 6 rows, corresponding to M-signals
        i = i+1;      
 end
 SNR = .6:.1:20;                       % signal to noise ratio per bit
SNR_dB = 10*log10(SNR)
semilogy(SNR_dB,BER)