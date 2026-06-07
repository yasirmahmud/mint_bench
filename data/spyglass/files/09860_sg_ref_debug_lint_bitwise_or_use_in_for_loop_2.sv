module lint_bitwise_or_ex2;
 reg [15:0] data_in;
 reg [7:0] result_out;
 integer i;
 initial begin data_in = 16'hFFFF;
 result_out = 8'h00;
 for (i = 0; i < 8; i = i + 1) begin result_out |= data_in[i];
 result_out |= data_in[i+1];
 end end endmodule
