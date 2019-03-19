
function Capacityreconfskv3 = Capacity_SMTreconfskv3(Nr,SNR_Vector,freqno,reconantenna)

Capacityreconfskv3=Nr*log2(1+10.^(SNR_Vector/10))+log2(freqno)+log2(reconantenna);
end