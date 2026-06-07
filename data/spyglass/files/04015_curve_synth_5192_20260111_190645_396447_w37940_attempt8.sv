module curve_synth_5192_20260111_190645_396447_w37940_attempt8 (
  input wire clk,
  input wire rst_n, // Active-low reset signal
  input wire din,
  output reg dout
);

  // SYNTH_5192 violation: The sensitivity list specifies negedge rst_n,
  // but the reset condition checks for an active-high state (rst_n == 1'b1).
  // This is a mismatch between the specified edge (negative edge for rst_n) 
  // and the logic level used in the reset condition (high for rst_n).
  always @(posedge clk or negedge rst_n) begin
    if (rst_n) begin // Condition checks for rst_n being high (inactive reset state for negedge reset)
      dout <= 1'b0; // This value is assigned when rst_n is high
    end else begin
      dout <= din;
    end
  end

endmodule
