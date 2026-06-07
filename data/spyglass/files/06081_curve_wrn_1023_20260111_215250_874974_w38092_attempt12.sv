module curve_wrn_1023_20260111_215250_874974_w38092_attempt12 (
  input wire clk,
  input wire reset_n,
  output reg [1:0] current_op_state
);

  // WRN_1023: enum directive requires parameter to have size specified
  // This warning is expected because the 'parameter' declaration itself lacks an explicit bit-width.
  // The 'synopsys enum [1:0]' pragma *does* contain a bit-width specification '[1:0]',
  // which is intended to satisfy STX_VE_483: "The enum pragma must include a size (bit-width) specification".
  // Previous attempts showed STX_VE_483 also being triggered; this attempt explicitly aims to isolate WRN_1023.
  parameter /* synopsys enum [1:0] */
    OP_IDLE = 2'b00,
    OP_BUSY = 2'b01,
    OP_DONE = 2'b10;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_op_state <= OP_IDLE;
    end else begin
      case (current_op_state)
        OP_IDLE: current_op_state <= OP_BUSY;
        OP_BUSY: current_op_state <= OP_DONE;
        OP_DONE: current_op_state <= OP_IDLE;
        default: current_op_state <= OP_IDLE;
      endcase
    end
  end

endmodule
