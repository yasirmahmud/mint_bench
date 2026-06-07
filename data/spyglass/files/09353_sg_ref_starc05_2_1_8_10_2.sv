module STARC05_2_1_8_10_ex2;
 function integer my_func;
 input [7:0] a;
 begin if (a > 10) begin my_func = a + 1;
 return;
 my_func = 0;
 end else begin my_func = a - 1;
 end end endfunction reg [7:0] data;
 initial begin data = my_func(20);
 data = my_func(5);
 end endmodule
