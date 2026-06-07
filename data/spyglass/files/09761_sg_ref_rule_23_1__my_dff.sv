module my_dff (input D, CLK, RST_N, output reg Q);
 always @(posedge CLK or negedge RST_N) begin if (!RST_N) Q <= 1'b0;
 else Q <= D;
 end endmodule
