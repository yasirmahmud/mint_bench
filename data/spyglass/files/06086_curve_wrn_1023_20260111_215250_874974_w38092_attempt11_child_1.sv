module curve_wrn_1023_20260111_215250_874974_w38092_attempt11 (
  input wire clk,
  input wire reset_n,
  output reg [1:0] current_fsm_state
);

  // WRN_1023: enum directive requires parameter to have size specified
  // This warning is expected because the 'parameter' declaration itself lacks an explicit bit-width,
  // e.g., 'parameter [1:0]'. The width is inferred from the assigned value's explicit width (2'dX).
  // The 'synopsys enum [1:0]' pragma *does* contain a bit-width, which is intended to prevent STX_VE_483.
  // FIX: Added explicit bit-width [1:0] to the parameter declaration to resolve WRN_1023 and STX_VE_483.
  parameter [1:0] /* synopsys enum [1:0] */
    STATE_A = 2'd0,
    STATE_B = 2'd1,
    STATE_C = 2'd2;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_fsm_state <= STATE_A;
    end else begin
      case (current_fsm_state)
        STATE_A: current_fsm_state <= STATE_B;
        STATE_B: current_fsm_state <= STATE_C;
        STATE_C: current_fsm_state <= STATE_A;
        default: current_fsm_state <= STATE_A;
      endcase
    end
  end

endmodule
