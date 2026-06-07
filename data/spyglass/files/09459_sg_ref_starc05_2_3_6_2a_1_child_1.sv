module multiple_resets_ex1 (CLK, RST1, RST2, DATA, Q);
 input CLK, RST1, RST2, DATA;
 output reg Q;
 always @(posedge CLK or negedge RST1 or negedge RST2) begin
  if (RST1 == 1'b0) begin
   Q = 1'b0;
  end else if (RST2 == 1'b0) begin
   Q = 1'b0;
  end else begin
   Q = DATA;
  end
 end
endmodule
