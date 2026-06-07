module curve_wrn_1023_20260111_215250_874974_w38092_attempt12 (
  input wire clk,
  input wire reset_n,
  output reg [1:0] current_op_state
);

  // WRN_1023: enum directive requires parameter to have size specified
  // STX_VE_483: The enum pragma must include a size (bit-width) specification
  // The fix moves the bit-width specification from inside the pragma to the parameter declaration itself,
  // satisfying the requirement that the parameter associated with the enum directive has an explicit size.
  parameter [1:0] /* synopsys enum */
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
