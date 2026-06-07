module STARC_2_3_6_2a_ex1 (CLK, RST1, RST2, DATA, Q);
  input CLK, RST1, RST2, DATA;
  output reg Q;

  // Combine the active-low asynchronous reset signals
  wire combined_reset_n;
  assign combined_reset_n = RST1 & RST2;

  // Modified sensitivity list to use the single combined_reset_n signal.
  // This resolves STARC05-2.3.3.1 and W422 by having only one clock edge
  // and one asynchronous reset edge in the event control.
  // It also resolves badimplicitSM1 as the combined_reset_n is explicitly
  // checked first and is now the direct asynchronous trigger.
  always @(posedge CLK or negedge combined_reset_n) begin
    // Check for the combined asynchronous reset first
    if (combined_reset_n == 1'b0) // Reset occurs if RST1 is low OR RST2 is low
      Q = 1'b0;
    else
      Q = DATA;
  end
endmodule
