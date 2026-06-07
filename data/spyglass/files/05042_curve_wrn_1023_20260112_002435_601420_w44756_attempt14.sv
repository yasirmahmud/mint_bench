module curve_wrn_1023_20260112_002435_601420_w44756_attempt14 (
  input wire clk,
  input wire rst_n,
  input wire start_op,
  output reg [2:0] current_state
);

  // WRN_1023: "enum directive requires parameter to have size specified"
  // This rule is expected to trigger because the 'parameter' keyword itself is not followed
  // by an explicit bit-width specification (e.g., '[2:0]').
  //
  // STX_VE_483: "The enum pragma must include a size (bit-width) specification"
  // Previous attempts (1-13) failed to isolate WRN_1023, as STX_VE_483 also triggered.
  // This happened even when the pragma included a bit-width like `/* synopsys enum [2:0] */`
  // on the same line as the 'parameter' keyword. This suggests a specific parsing behavior
  // by SpyGlass for the pragma's location or format.
  //
  // This attempt aims to isolate WRN_1023 by making the following changes:
  // 1. The 'parameter' declaration itself *lacks* a bit-width (e.g., `parameter CMD_IDLE = ...`),
  //    which should trigger WRN_1023.
  // 2. The 'synopsys enum [X:0]' pragma is placed on a *separate line* immediately preceding
  //    the 'parameter' declaration. This common Verilog pragma placement is intended to satisfy
  //    STX_VE_483, assuming SpyGlass will correctly associate the bit-width within the pragma.
  //    If successful, only WRN_1023 should be reported.

  /* synopsys enum [2:0] */
  parameter
    CMD_IDLE  = 3'b000,
    CMD_READ  = 3'b001,
    CMD_WRITE = 3'b010,
    CMD_FLUSH = 3'b011;

  reg [2:0] internal_cmd_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_cmd_state <= CMD_IDLE;
      current_state      <= CMD_IDLE; // Output for demonstration
    end else begin
      case (internal_cmd_state)
        CMD_IDLE: begin
          if (start_op) begin
            internal_cmd_state <= CMD_READ;
          end else begin
            internal_cmd_state <= CMD_IDLE;
          end
        end
        CMD_READ: begin
          internal_cmd_state <= CMD_WRITE;
        end
        CMD_WRITE: begin
          internal_cmd_state <= CMD_FLUSH;
        end
        CMD_FLUSH: begin
          internal_cmd_state <= CMD_IDLE;
        end
        default: begin
          // Defensive default, should not be reached with a well-defined state machine
          internal_cmd_state <= CMD_IDLE;
        end
      endcase
      current_state <= internal_cmd_state; // Update output
    end
  end

endmodule
