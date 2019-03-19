
SNR_Vector=-10:1:15;
cappqsm1=Capacity_SMTreconfskv3(4,SNR_Vector,1,1);
figure;
grid on;
plot(SNR_Vector,cappqsm1,'-^r')
hold on
cappqsm2=Capacity_SMTreconfskv3(8,SNR_Vector,1,1);
plot(SNR_Vector,cappqsm2,'-^b')
hold on
cappqsm3=Capacity_SMTreconfskv3(4,SNR_Vector,2,2);
plot(SNR_Vector,cappqsm3,'-^m')
hold on
cappqsm4=Capacity_SMTreconfskv3(8,SNR_Vector,2,2);
plot(SNR_Vector,cappqsm4,'-^k')
hold on
cappqsm5=Capacity_SMTreconfskv3(4,SNR_Vector,4,2);
plot(SNR_Vector,cappqsm5,'-^y')
hold on
cappqsm6=Capacity_SMTreconfskv3(8,SNR_Vector,4,4);
plot(SNR_Vector,cappqsm6,'-^c')
hold on
legend('QSM 4RX','QSM 8RX','proposed QSM+2FSK+2RECON 4RX','proposed QSM+2FSK+2RECON 8RX','proposed QSM+4FSK+2RECON 8RX','proposed QSM+4FSK+4RECON 8RX')
xlabel('SNR')
ylabel('bits per channel use (bpcu)')