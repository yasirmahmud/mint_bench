module curve_starc05_2_11_3_1_20260111_231128_271450_w28836_attempt12 (
  input wire        clk,
  input wire        rst_n,
  input wire        start_i,
  input wire        data_i,
  output reg        done_o,
  output reg        active_o
);

  // State parameterization
  parameter [1:0] STATE_IDLE    = 2'b00;
  parameter [1:0] STATE_WORKING = 2'b01;
  parameter [1:0] STATE_DONE    = 2'b10;

  reg [1:0] current_state;
  reg [1:0] next_state_logic; // This register holds the combinational next-state calculation
                              // before being assigned to current_state sequentially.

  // This always block contains both the sequential (state update) and
  // combinational (next-state/output logic) parts of the FSM.
  // This architectural mixing within a single synchronous block is the
  // direct cause of the STARC05-2.11.3.1 violation.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Sequential reset for all state elements and registered outputs
      current_state    <= STATE_IDLE;
      done_o           <= 1'b0;
      active_o         <= 1'b0;
      next_state_logic <= STATE_IDLE; // Reset for the next-state calculation variable
    end else begin
      // Default assignments for next-state logic and outputs
      // These are combinational calculations (using non-blocking for consistency within block)
      next_state_logic <= current_state; // Default to stay in current state
      done_o           <= 1'b0;
      active_o         <= 1'b0;

      // --- Combinational next-state and output logic calculation ---
      // This 'case' statement implements the combinational logic for the FSM's next state
      // and registered output updates. Being placed inside the synchronous always block
      // (alongside the current_state update) triggers the STARC05-2.11.3.1 violation.
      case (current_state)
        STATE_IDLE: begin
          if (start_i) begin
            next_state_logic <= STATE_WORKING;
            active_o         <= 1'b1;
          end
          // else: next_state_logic and outputs retain default (stay in IDLE, outputs 0)
        end
        STATE_WORKING: begin
          if (data_i) begin // Assume data_i signals completion
            next_state_logic <= STATE_DONE;
            done_o           <= 1'b1;
          end else begin
            active_o         <= 1'b1;
          end
        end
        STATE_DONE: begin
          next_state_logic <= STATE_IDLE; // Transition back to IDLE automatically
          done_o           <= 1'b1; // Output remains done for one cycle, then goes to IDLE
        end
        default: begin // Handle unexpected states, though unlikely with 2'bXX
          next_state_logic <= STATE_IDLE;
        end
      endcase

      // --- Sequential FSM state update ---
      // The actual FSM state register updates at the positive clock edge.
      current_state <= next_state_logic;
    end
  end

endmodule
