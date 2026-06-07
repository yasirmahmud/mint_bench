module star_2_1_8_7_ex1(input a, output reg o);
 function integer my_func;
 input i;
 reg dummy_var;
 begin if (i > 0) begin return 1;
 dummy_var = 0;
 end return 0;
 end endfunction always @(*) o = my_func(a);
 endmodule
