module multiple_resets_ex2(CLK, RST1, RST2, DATA, Q);
 input CLK, RST1, RST2, DATA;
 output reg Q;
 always @(posedge CLK or negedge RST1 or negedge RST2) begin if (!RST1 || !RST2) Q = 1'b0;
 else Q = DATA;
 end endmodule
