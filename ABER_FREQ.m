function ABER_Ana=ABER_FREQ(M,Nt,Nr,SNR_Vector,freq_num,reconfigant)

%
%Description
%Thisscriptcalculatestheanalyticalaveragebiterrorratio(ABER)
%ofquadraturespatialmodulation(QSM)overRayleighfadingchannel
%withnochannelestimationerrors(CSEs).
%
%Inputs
%MSizeofthesignalconstellationdiagram.
%
%NtNumberoftransmitantennas.
%
%NrNumberofreceiveantennas.
%
%SNR_VectorVectorcontainingthesignal-to-noiseratio(SNR)
%valuestocalculatetheABERover.
%
%Output
%ABER_AnaThecalculatedanalyticalABERofQAM.
%
%Usage
%ABER_Ana=ABER_ANA_QSM_Rayleigh_no_CSE(M,Nt,Nr,SNR_Vector)
%%GeneratingtheM-QAMsignalconstellationsymbols
%ConstructinganM-QAMmodulator
alphabit=modem.qammod('M',M);
%Generatingsignalconstellationdiagram
S=modulate(alphabit,(0:M-1)).';
%Calculatingaveragepowerofthesignalconstellationdiagram
S_avg=S'*S/M;
%Normalizingthepowerofthesignalconstellationdiagram
S=S/sqrt(S_avg);
%%CalculatingAnalyticalABER
%CalculatingthespectralefficiencyofSM
eta=2*log2(Nt)+log2(M)+log2(freq_num)+log2(reconfigant);
%PreallocatevariablestostorethecalculatedABER
ABER_Ana=zeros(size(SNR_Vector));
for snr=1:length(SNR_Vector)
%Calculatingthenoisevariancesigma_n^2
%Note,E[|Hx|^2]=1isassumed
sigma_n=(1/10^(SNR_Vector(snr)/10));
    for ellRe_t=1:Nt
        for ellIm_t=1:Nt
            for ellRe=1:Nt
                for ellIm=1:Nt
                    for i_t=1:M
                        for i=1:M
                            if ellRe_t==ellRe&&ellIm_t==ellIm
                                Psi=abs(real(S(i_t))-real(S(i)))^2+abs(imag(S(i_t))-imag(S(i)))^2;
                                BarGamma_QSM=(1/(2*sigma_n))*Psi;
                            elseif  ellRe_t~=ellRe&&ellIm_t==ellIm
                                Psi=abs(real(S(i_t)))^2+abs(real(S(i)))^2+abs(imag(S(i_t))-imag(S(i)))^2;
                                BarGamma_QSM=(1/(2*sigma_n))*Psi;
                            elseif  ellRe_t == ellRe&&ellIm_t~=ellIm
                                Psi=abs(real(S(i_t))-real(S(i)))^2+abs(imag(S(i_t)))^2+abs(imag(S(i)))^2;
                                BarGamma_QSM=(1/(2*sigma_n))*Psi;
                            elseif  ellRe_t ~= ellRe && ellIm_t ~= ellIm
                                Psi=abs(S(i_t))^2+abs(S(i_t))^2;
                                BarGamma_QSM=(1/(2*sigma_n))*Psi;
                            end
                            alpha_a=(1/2)*(1-sqrt((BarGamma_QSM/2)/(1+(BarGamma_QSM/2))));
                            %CalculatingthePEPfor this event
                            PEP=0;
                            for nr=0:(Nr-1)
                            PEP=PEP+nchoosek(Nr-1+nr,nr)*(1-alpha_a)^nr;
                            end
                            PEP=alpha_a^Nr*PEP;
%Numberofbitsinerrorfor thisevent
                            btE=(biterr(ellRe_t-1,ellRe-1,log2(Nt))+biterr(ellIm_t-1,ellIm-1,log2(Nt))+biterr(i_t-1,i-1,log2(M)))/eta;
                            ABER_Ana(snr)=ABER_Ana(snr)+btE*PEP;
                        end
                    end
                end
            end
        end
    end
end
ABER_Ana=ABER_Ana/2^eta;
