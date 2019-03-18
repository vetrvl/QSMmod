%QSM 
%make sure length should be multiples of log2(M)+2*log2(Nt)
len_user=1e4;
%bits for signal modulation
M=16;
Nt=16;
len=(log2(M)+(log2(Nt)*2))*len_user;
if M==2
    sig_bits_count=2;
else
    sig_bits_count=log2(M);
end
space_bits_count=log2(Nt);
bits=randn(1,len);
bits(find(bits>0))=1;
bits(find(bits<=0))=0;
%Modulation
%reshaping input
tot_bits_to_modulate=(sig_bits_count+(2*space_bits_count));
bit_reshape=(reshape(bits,tot_bits_to_modulate,len/tot_bits_to_modulate)).';
[ro,cl]=size(bit_reshape);
tx=zeros(ro,Nt);
for no_of_blocks=1:ro
    symbol_modul=bit_reshape(no_of_blocks,1:sig_bits_count);
    if M==2
        symb=qpskmodul(symbol_modul);
    else
        symb=qammodul(symbol_modul,M);
    end
    
%%
%considering there are 4 antennas 
%let say antenna 1 is 00
%let say antenna 2 is 01
%let say antenna 3 is 10
%let say antenna 4 is 11
next_i_bits=bit_reshape(no_of_blocks,(sig_bits_count+1):(sig_bits_count+space_bits_count));
next_q_bits=bit_reshape(no_of_blocks,(sig_bits_count+length(next_i_bits)+1):end);

%transmit matrix
pos_i=bi2de(next_i_bits,'left-msb')+1;
pos_q=bi2de(next_q_bits,'left-msb')+1;
tx_i=zeros(1,Nt);
tx_q=zeros(1,Nt);
tx_i(1,pos_i)=real(symb)*1;
tx_q(1,pos_q)=imag(symb)*1j;
tx(no_of_blocks,:)=tx_i(1,:)+tx_q(1,:);
end
%tx_in_channel=awgn(tx.',0,'measured');
tx_in_channel=tx.';
%%
%receiver block
[rcvd_block_size_ro,rcvd_block_size_cl]=size(tx_in_channel);
rxd=zeros(size(tx_in_channel));
strt_idx_space_bits=sig_bits_count+1;
decod_bits=zeros(tot_bits_to_modulate,len/tot_bits_to_modulate);
for blcks=1:rcvd_block_size_cl
    rxd(:,blcks)=tx_in_channel(:,blcks);
    %finding implicit data(which means antenna)
    re_val_pos=find(abs(real(rxd(:,blcks)))>0);
    img_val_pos=find(abs(imag(rxd(:,blcks)))>0);
    
    %rcvd i bits(from I antenna)
    rxd_i_bits=de2bi(re_val_pos-1,'left-msb');
    %check if the size is log2(Nt) or else pad zeros
    if length(rxd_i_bits)~=space_bits_count
        rxd_i_bits=[zeros(1,space_bits_count-length(rxd_i_bits)) rxd_i_bits];
    end
    
    %rcvd i bits(from Q antenna)
    rxd_q_bits=de2bi(img_val_pos-1,'left-msb');
    %check if the size is log2(Nt) or else pad zeros
    if length(rxd_q_bits)~=space_bits_count
        rxd_q_bits=[zeros(1,space_bits_count-length(rxd_q_bits)) rxd_q_bits];
    end
    %finding last 4 bits or space bits
    re_val=real(rxd(re_val_pos,blcks));
    img_val=imag(rxd(img_val_pos,blcks));
    
    cmplx_val=re_val+1i*(img_val);
    %explicit decoding
    if M==2
        expli_bits=qpskdemodul(cmplx_val);
    else
        expli_bits=qamdemodul(cmplx_val,M,sig_bits_count);
    end
    decod_bits(:,blcks)=[expli_bits rxd_i_bits rxd_q_bits].';   
end
decod_bits=reshape(decod_bits,1,len);
err=length(find(bits~=decod_bits));
