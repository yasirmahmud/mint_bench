module ShiftLatch_ex1 (input clk, input data_in, output [21:0] data_out);
 reg [21:0] shift_reg;
 integer i;
 always @(clk or data_in or shift_reg) if (clk) begin shift_reg[0] = data_in;
 for (i = 0; i < 21; i = i + 1) shift_reg[i+1] = shift_reg[i];
 end assign data_out = shift_reg;
 endmodule
