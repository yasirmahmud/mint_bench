module STARC05_2_9_2_2_ex1();
 reg [7:0] i;
 reg non_constant_reg;
 reg out_signal;
 initial begin for (i = 0; i < 8; i = i + 1) begin if (non_constant_reg == 1'b0) begin out_signal = 1'b1;
 end else begin out_signal = 1'b0;
 end end end endmodule
