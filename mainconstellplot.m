
%M=4;
%Nt=4;
%Nr=4;
%SNR_Vector=-15:1:15;
%BBB=ABER_ANA_QSM_Rayleigh_no_CSE(M,Nt,Nr,SNR_Vector)
%semilogy(SNR_Vector,BBB)

SNR_Vector=-10:1:15;
BBB=ABER_ANA_QSM_Rayleigh_no_CSE(4,4,4,SNR_Vector);
figure;
semilogy(SNR_Vector,BBB,'-*b') % QPSK/4TX/4RX
hold on
DDD=ABER_ANA_QSM_Rayleigh_no_CSE(4,8,4,SNR_Vector); 
semilogy(SNR_Vector,DDD,'-*g')% QPSK/8TX/4RX
hold on
CCC=ABER_ANA_QSM_Rayleigh_no_CSE(16,4,4,SNR_Vector);
semilogy(SNR_Vector,CCC,'-*r') % 16QAM/4TX/4RX
hold on
EEE=ABER_ANA_QSM_Rayleigh_no_CSE(16,8,4,SNR_Vector);
semilogy(SNR_Vector,CCC,'-*y') % 16QAM/8TX/4RX
hold on
freq_num=2;
reconfigant=1;
RRR=ABER_FREQ(4,4,4,SNR_Vector,freq_num,reconfigant);
semilogy(SNR_Vector,RRR,'-^k') % QPSK/4TX/4RX/2Freq
hold on
reconfigant=2;
GGG=ABER_FREQ(4,4,4,SNR_Vector,freq_num,reconfigant);
semilogy(SNR_Vector,RRR,'-^m') % QPSK/4TX/4RX/2Freq
