module STARC05_2_10_8_2_ex1;
 reg [15:0] data_in;
 reg [3:0] divisor;
 wire [15:0] result;
 assign result = data_in / divisor;
 endmodule
