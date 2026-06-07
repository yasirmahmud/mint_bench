module curve_synth_5192_20260111_224011_052670_w15680_attempt11 (
  input wire sys_clk,
  input wire reset_sig_p, // Intended active-high reset
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // SYNTH_5192 violation:
  // The sensitivity list specifies a positive edge for 'reset_sig_p' (posedge reset_sig_p),
  // implying an active-high reset. However, the 'if' condition checks for
  // 'reset_sig_p == 1'b0', which implies an active-low reset, creating a mismatch.
  always @(posedge sys_clk or posedge reset_sig_p) begin
    if (reset_sig_p == 1'b0) begin // Mismatch: Checking for active-low, but sensitive to posedge
      data_out <= 4'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
