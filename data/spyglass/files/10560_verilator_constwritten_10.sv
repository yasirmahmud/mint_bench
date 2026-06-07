module const_write_10;
  const int value = 100;
  function automatic int get_value();
    value = 200;
    return value;
  endfunction
endmodule
