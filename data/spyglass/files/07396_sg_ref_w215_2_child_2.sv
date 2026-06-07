module w215_ex2(output wire my_bit);
 reg [31:0] my_int = 32'h0;

 assign my_bit = my_int[0];
 endmodule
