module curve_wrn_1023_20260112_002435_601420_w44756_attempt15 (
  input wire clk,
  input wire rst_n,
  output reg [1:0] current_state
);

  // WRN_1023: "enum directive requires parameter to have size specified"
  // This rule is expected to trigger because the 'parameter' keyword itself is not followed
  // by an explicit bit-width specification (e.g., '[1:0]').
  //
  // STX_VE_483: "The enum pragma must include a size (bit-width) specification"
  // Previous attempts (1-4 from context) where the pragma was on the same line as 'parameter'
  // and included a bit-width (e.g., `/* synopsys enum [1:0] */`) still triggered both STX_VE_483 and WRN_1023.
  // This suggests that for STX_VE_483, SpyGlass might expect a more complete pragma format.
  //
  // In this attempt, to isolate WRN_1023, the 'synopsys enum' pragma is modified to include
  // a placeholder type identifier (e.g., 'my_state_t') in addition to the bit-width (e.g., '[1:0]').
  // This specific format `/* synopsys enum <type> [width] */` is hypothesized to satisfy STX_VE_483
  // while still allowing WRN_1023 to trigger because the 'parameter' keyword itself lacks a bit-width.

  parameter /* synopsys enum my_state_t [1:0] */
    IDLE_STATE = 2'd0,
    ACTIVE_STATE = 2'd1;

  always @(posedge clk) begin
    if (!rst_n) begin // Active low reset
      current_state <= IDLE_STATE;
    end else begin
      current_state <= ACTIVE_STATE; // Trivial logic to use the parameter values
    end
  end

endmodule
