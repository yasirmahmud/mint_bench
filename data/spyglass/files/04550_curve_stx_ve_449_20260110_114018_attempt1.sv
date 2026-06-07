module curve_stx_ve_449_20260110_114018_attempt1 (
  input wire clk,
  output wire [1:0] state_out
);

  // STX_VE_449: Size of the enumeration constant ( 2 ) for enum label STATE_DONE is more than the range specified for the enumeration
  // SpyGlass often infers 'enumerations' from a sequence of localparams.
  // If two state labels are defined, SpyGlass might infer a 1-bit range (max value 1).
  // By explicitly assigning STATE_DONE a value of 2, which requires 2 bits,
  // it violates the inferred 1-bit range for an enumeration with two labels.
  localparam STATE_ACTIVE = 1'b0;  // Value 0, needs 1 bit.
  localparam STATE_DONE   = 2'b10; // Value 2, needs 2 bits.

  reg [1:0] current_state_r;

  assign state_out = current_state_r;

  always @(posedge clk) begin
    // Simple state machine to use the constants and avoid unused warnings.
    case (current_state_r)
      STATE_ACTIVE: current_state_r <= STATE_DONE;
      STATE_DONE:   current_state_r <= STATE_ACTIVE;
      default:      current_state_r <= STATE_ACTIVE;
    endcase
  end

endmodule
