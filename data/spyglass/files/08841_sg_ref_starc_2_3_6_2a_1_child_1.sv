module STARC_2_3_6_2a_ex1 (CLK, RST1, RST2, DATA, Q);
  input CLK, RST1, RST2, DATA;
  output reg Q;

  // Combine the active-low asynchronous reset signals
  // This resolves W442f by using '==' for the reset condition
  // and also addresses badimplicitSM1 by ensuring a clear reset check.
  wire combined_reset_n;
  assign combined_reset_n = RST1 & RST2;

  always @(posedge CLK or negedge RST1 or negedge RST2) begin
    // Check for the combined asynchronous reset first
    if (combined_reset_n == 1'b0) // Both RST1 and RST2 must be high for no reset
      Q = 1'b0;
    else
      Q = DATA;
  end
endmodule
