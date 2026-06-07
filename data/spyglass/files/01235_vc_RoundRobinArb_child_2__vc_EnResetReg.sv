module vc_EnResetReg
#(
  parameter p_width      = 1,
  parameter p_reset_value = 0 // Default, but overridden by instantiation
)(
  input  wire                  clk,
  input  wire                  reset,
  input  wire                  en,
  input  wire [p_width-1:0]    d,
  output reg  [p_width-1:0]    q
);

  // Assuming p_width >= 1 for practical use cases of an arbiter chain.
  // If p_width is 0, the register is effectively empty, and no logic is required.
  // The Verilog standard for 0-width vectors handles this gracefully in most tools.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= p_reset_value;
    end else if (en) begin
      q <= d;
    end
  end

endmodule
