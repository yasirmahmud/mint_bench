module sync_reset_ex2 (OUT, CLK, RST, IN);
 input CLK, RST, IN;
 output OUT;
 reg OUT;
 always @ (posedge CLK) begin if (RST) OUT = 1'b0;
 else OUT = IN;
 end endmodule
