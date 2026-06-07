module multiple_clocks_ex2(input CLK1, input CLK2, input IN1, output reg OUT1);
 always @(posedge CLK1 or posedge CLK2) begin OUT1 = IN1;
 end endmodule
