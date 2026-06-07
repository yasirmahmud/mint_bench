module DFF_AR (input D, CLK, ARST_N, output Q);
 reg Q_reg;
 always @(posedge CLK or negedge ARST_N) begin if (!ARST_N) Q_reg <= 1'b0;
 else Q_reg <= D;
 end assign Q = Q_reg;
 endmodule
