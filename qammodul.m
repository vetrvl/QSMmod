function symb=qammodul(array,M)
  len=length(array);
  one_word=log2(M);
  dec_bits=reshape(array,len/one_word,one_word);
  bits_2_dec=bi2de(dec_bits,'left-msb');
  bits_2_sym=qammod(bits_2_dec,M);
  symb=bits_2_sym;