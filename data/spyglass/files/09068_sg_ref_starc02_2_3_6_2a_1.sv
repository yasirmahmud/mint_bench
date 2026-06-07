module multiple_resets_ex1 (input CLK, input RST1, input RST2, input DATA, output reg Q);
 always @(posedge CLK or negedge RST1 or negedge RST2) begin if (!RST1 || !RST2) Q = 1'b0;
 else Q = DATA;
 end endmodule
