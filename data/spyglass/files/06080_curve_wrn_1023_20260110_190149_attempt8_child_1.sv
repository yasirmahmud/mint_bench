module curve_wrn_1023_20260110_190149_attempt8 (
  input wire clk,
  input wire rst,
  output reg out_sig
);

  // WRN_1023 target: The 'enum directive requires parameter to have size specified'.
  // This is triggered because the 'parameter' declaration itself does not include a bit-width range (e.g., [1:0]).
  // The 'synopsys enum fsm' pragma *does* include a size '[1:0]' to avoid STX_VE_483, which states
  // 'The enum pragma must include a size (bit-width) specification'.
  // FIX: Added [1:0] to the parameter declaration itself to resolve WRN_1023 and STX_VE_483.
  parameter [1:0] /* synopsys enum fsm [1:0] */
    STATE_IDLE = 2'd0,
    STATE_RUN  = 2'd1,
    STATE_STOP = 2'd2;

  // Declare a state register with an explicit bit-width and a 'synopsys enum fsm' pragma that also includes a size.
  // This is intended to satisfy STX_VE_483, as previous attempts showed this rule being triggered even when
  // the parameter's pragma had a size. This approach assumes STX_VE_483 might be sensitive to the overall
  // enum declaration context, including the state register's pragma.
  reg [1:0] /* synopsys enum fsm [1:0] */ current_state;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= STATE_IDLE;
      out_sig <= 1'b0;
    end else begin
      case (current_state)
        STATE_IDLE: begin
          current_state <= STATE_RUN;
          out_sig <= 1'b0;
        end
        STATE_RUN: begin
          current_state <= STATE_STOP;
          out_sig <= 1'b1;
        end
        STATE_STOP: begin
          current_state <= STATE_IDLE;
          out_sig <= 1'b0;
        end
        default: begin // Ensure full case to avoid latches
          current_state <= STATE_IDLE;
          out_sig <= 1'b0;
        end
      endcase
    end
  end

endmodule
