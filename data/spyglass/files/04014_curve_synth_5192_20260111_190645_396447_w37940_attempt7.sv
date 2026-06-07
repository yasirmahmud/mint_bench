module curve_synth_5192_20260111_190645_396447_w37940_attempt7 (
  input wire clk,
  input wire rst,
  input wire din,
  output reg dout
);

  // SYNTH_5192 violation: The sensitivity list specifies a posedge rst,
  // but the reset condition checks for active-low (!rst), which is a mismatch
  // between the specified edge and the logic level in the condition.
  always @(posedge clk or posedge rst) begin
    if (!rst) begin // Reset condition checks for active-low rst
      dout <= 1'b0;
    end else begin
      dout <= din;
    end
  end

endmodule
