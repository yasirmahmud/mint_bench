module curve_stx_ve_483_20260110_115124_attempt1 (
  input clk,
  input rst,
  output reg out_signal
);

  // STX_VE_483: The enum pragma must include a size (bit-width) specification.
  // This pragma lacks the '[size]' specifier, e.g., /* synopsys enum fsm [2] */
  parameter /* synopsys enum fsm [2] */
    STATE_IDLE  = 2'b00,
    STATE_ACTIVE = 2'b01,
    STATE_FINISH = 2'b10;

  reg [1:0] current_state;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= STATE_IDLE;
      out_signal <= 1'b0;
    end else begin
      case (current_state)
        STATE_IDLE: begin
          current_state <= STATE_ACTIVE;
          out_signal <= 1'b0;
        end
        STATE_ACTIVE: begin
          current_state <= STATE_FINISH;
          out_signal <= 1'b1;
        end
        STATE_FINISH: begin
          current_state <= STATE_IDLE;
          out_signal <= 1'b0;
        end
        default: begin // Handle unexpected states gracefully
          current_state <= STATE_IDLE;
          out_signal <= 1'b0;
        end
      endcase
    end
  end

endmodule
