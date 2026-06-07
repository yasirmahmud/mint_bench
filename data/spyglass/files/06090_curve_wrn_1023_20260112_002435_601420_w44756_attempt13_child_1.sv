module curve_wrn_1023_20260112_002435_601420_w44756_attempt13 (
  input wire clk,
  input wire rst_n,
  input wire start_op,
  output reg [2:0] current_state
);

  // WRN_1023: "enum directive requires parameter to have size specified"
  // This rule is expected to trigger because the 'parameter' keyword is not followed
  // by an explicit bit-width specification (e.g., [2:0]) for the enumeration.
  // 
  // The 'synopsys enum [2:0]' pragma itself includes a bit-width specification.
  // This is intended to satisfy STX_VE_483 ("The enum pragma must include a size"),
  // thus isolating WRN_1023. However, based on provided context examples, it has
  // been observed that both WRN_1023 and STX_VE_483 can sometimes trigger simultaneously
  // even when the pragma contains a bit-width. This attempt specifically aims to
  // isolate WRN_1023 by ensuring the pragma is correctly formed for STX_VE_483.
  parameter [2:0] /* synopsys enum [2:0] */
    STATE_IDLE    = 3'b000,
    STATE_SETUP   = 3'b001,
    STATE_PROCESS = 3'b010,
    STATE_FINISH  = 3'b011;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= STATE_IDLE;
    end else begin
      case (current_state)
        STATE_IDLE: begin
          if (start_op) begin
            current_state <= STATE_SETUP;
          end else begin
            current_state <= STATE_IDLE;
          end
        end
        STATE_SETUP: begin
          current_state <= STATE_PROCESS;
        end
        STATE_PROCESS: begin
          // Simulate some processing stage
          current_state <= STATE_FINISH;
        end
        STATE_FINISH: begin
          current_state <= STATE_IDLE;
        end
        default: begin
          // Should not happen with a well-defined state machine using enum parameters
          current_state <= STATE_IDLE;
        end
      endcase
    end
  end

endmodule
