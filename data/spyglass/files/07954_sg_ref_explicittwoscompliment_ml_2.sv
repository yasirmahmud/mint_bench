module explicit_twos_compliment_ex2;
 wire [7:0] data_in;
 wire [7:0] result;
 assign result = ~data_in + 1;
 endmodule
