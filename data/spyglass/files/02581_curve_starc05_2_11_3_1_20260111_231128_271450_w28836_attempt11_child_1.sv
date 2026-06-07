module curve_starc05_2_11_3_1_20260111_231128_271450_w28836_attempt11 (
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
  reg [1:0] next_state; // Combinational signal for next state

  // Internal signals for next output values (combinational drivers for registered outputs)
  reg done_o_comb;
  reg active_o_comb;

  // --- Sequential Logic Block ---
  // This block updates the state register and output registers on the clock edge or reset.
  // All assignments here must be non-blocking ('<=').
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= STATE_IDLE;
      done_o        <= 1'b0;
      active_o      <= 1'b0;
    end else begin
      current_state <= next_state;
      done_o        <= done_o_comb;
      active_o      <= active_o_comb;
    end
  end

  // --- Combinational Logic Block ---
  // This block determines 'next_state' and the combinatorial values for the next cycle's outputs.
  // Using an 'always @*' block ensures all relevant signals are in the sensitivity list.
  // All assignments here must be blocking ('=').
  always @* begin
    // Default assignments for 'next_state', 'active_o_comb', 'done_o_comb'
    // to prevent latches. These defaults establish a baseline for all state paths.
    next_state    = current_state; // Default: stay in current state
    active_o_comb = 1'b0;          // Default to inactive unless explicitly set
    done_o_comb   = 1'b0;          // Default to not done unless explicitly set

    case (current_state) begin
      STATE_IDLE: begin
        if (start_i) begin
          next_state    = STATE_WORKING;
          active_o_comb = 1'b1;
          done_o_comb   = 1'b0;
        end else begin
          next_state    = STATE_IDLE;
          active_o_comb = 1'b0;
          done_o_comb   = 1'b0;
        end
      end
      STATE_WORKING: begin
        if (data_i) begin // Assume data_i signals completion
          next_state    = STATE_DONE;
          active_o_comb = 1'b0;
          done_o_comb   = 1'b1;
        end else begin
          next_state    = STATE_WORKING;
          active_o_comb = 1'b1;
          done_o_comb   = 1'b0;
        end
      end
      STATE_DONE: begin
        next_state    = STATE_IDLE; // Transition back to IDLE automatically
        active_o_comb = 1'b0;
        done_o_comb   = 1'b1;
      end
      default: begin
        // Handle unexpected/unreachable states by returning to a known safe state.
        next_state    = STATE_IDLE;
        active_o_comb = 1'b0;
        done_o_comb   = 1'b0;
      end
    endcase
  end

endmodule
