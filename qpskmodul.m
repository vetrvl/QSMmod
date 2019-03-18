function symb=qpskmodu(array)
    len=length(array);
    array=2.*array-1*ones(1,len);
    bits_2_sym=array(1:2:end)+1i*(array(2:2:end));
    symb=bits_2_sym;