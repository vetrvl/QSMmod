
M=4;
Nt=4;
Nr=4;
SNR_Vector=-15:1:15;
BBB=ABER_ANA_QSM_Rayleigh_no_CSE(M,Nt,Nr,SNR_Vector)
semilogy(SNR_Vector,BBB)