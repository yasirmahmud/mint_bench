module star_c05_2_1_8_4_ex1;
  function automatic int my_func;
    reg [7:0] my_array [0:3];
    my_array = '{0: 8'h10, 1: 8'h20, default: '0};
    my_func = my_array[0];
  endfunction
endmodule
