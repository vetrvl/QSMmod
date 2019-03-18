function bits=qpskdemodul(array)
    len=length(array);
    bits=zeros(2,len);
    for array_len=1:len
        bits(:,array_len)=[real(array(array_len))>0 imag(array(array_len))>0].';
    end
    bits=reshape(bits,1,len*2);