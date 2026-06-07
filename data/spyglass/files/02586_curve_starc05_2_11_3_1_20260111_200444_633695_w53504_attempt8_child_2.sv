module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt8 (
  input wire clk,
  input wire reset,
  input wire start_button,
  input wire stop_button,
  output reg busy_indicator
);

  // Define states for a simple FSM
  localparam [0:0]
    STATE_IDLE   = 1'b0,
    STATE_ACTIVE = 1'b1;

  // State register
  reg [0:0] current_state;
  // Wires for combinational next-state and next-output logic
  // Changed 'wire' to 'reg' for procedural assignments in the always @(*) block.
  reg [0:0] next_state;
  reg next_busy_indicator;

  // Combinational logic block for next state and next output
  // This block uses blocking assignments (=) and is sensitive to current_state and inputs.
  always @(*) begin
    // Default to staying in the current state and keeping the output value
    // This helps avoid unintended latches.
    next_state = current_state;
    next_busy_indicator = busy_indicator; // Default for registered output

    case (current_state) 
      STATE_IDLE: begin
        if (start_button) begin
          next_state = STATE_ACTIVE;
          next_busy_indicator = 1'b1;
        end else begin
          next_state = STATE_IDLE;
          next_busy_indicator = 1'b0;
        }
      end
      STATE_ACTIVE: begin
        if (stop_button) begin
          next_state = STATE_IDLE;
          next_busy_indicator = 1'b0;
        }
        else begin
          next_state = STATE_ACTIVE;
          next_busy_indicator = 1'b1;
        end
      end
      default: begin // Defensive programming for unhandled states (e.g., X/Z states)
        next_state = STATE_IDLE;
        next_busy_indicator = 1'b0;
      end
    endcase
  end

  // Sequential logic block for state register and registered output updates
  // This block uses non-blocking assignments (<=) and is sensitive to clock and reset.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= STATE_IDLE;
      busy_indicator <= 1'b0;
    end else begin
      current_state <= next_state;
      busy_indicator <= next_busy_indicator;
    end
  end

endmodule
