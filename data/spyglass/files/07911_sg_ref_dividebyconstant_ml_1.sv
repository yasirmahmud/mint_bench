module DivideByConstant_ex1;
 reg [7:0] data_in;
 wire [7:0] result;
 parameter DIVISOR = 4;
 initial begin data_in = 100;
 end assign result = data_in / DIVISOR;
 endmodule
