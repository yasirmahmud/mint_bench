module value_size_overflow_ex2;
 integer my_int;
 localparam [32:0] WIDE_VAL = 33'h1_00000000;
 initial begin my_int = WIDE_VAL;
 $display("Value: %d", my_int);
 end endmodule
