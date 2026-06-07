module curve_synth_5192_20260111_224011_052670_w15680_attempt12 (
  input wire clk,
  input wire sync_reset_n, // Active-low reset by convention
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // SYNTH_5192 violation:
  // The sensitivity list specifies a negative edge for 'sync_reset_n' (negedge sync_reset_n),
  // implying an active-low reset. However, the 'if' condition checks for
  // 'sync_reset_n == 1'b1' (or simply 'if (sync_reset_n)'), which implies an active-high reset,
  // creating a mismatch between the edge specified in the sensitivity list
  // and the logic level checked in the reset condition.
  always @(posedge clk or negedge sync_reset_n) begin
    if (sync_reset_n == 1'b1) begin // Mismatch: Sensitive to negedge, but condition checks for high
      data_out <= 8'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
