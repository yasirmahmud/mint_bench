module curve_stx_ve_483_20260110_115124_attempt5 (
  input clk,
  input rst,
  output reg [1:0] out_state
);

  // STX_VE_483: The enum pragma must include a size (bit-width) specification.
  // This pragma intentionally lacks the '[size]' specifier to trigger STX_VE_483.
  // Applying it to a 'reg' instead of a 'parameter' helps avoid WRN_1023,
  // which specifically mentions parameters.
  reg [1:0] /* synopsys enum fsm */ current_state; // Expected to trigger STX_VE_483

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= 2'b00;
    end else begin
      // Simple state machine to use current_state and prevent latches
      case (current_state)
        2'b00: current_state <= 2'b01;
        2'b01: current_state <= 2'b10;
        2'b10: current_state <= 2'b11; // Added another state for completeness
        default: current_state <= 2'b00;
      endcase
    end
  end

  // Assign current_state to an output to avoid unused signal warning (e.g., WRN_1001)
  assign out_state = current_state;

endmodule
