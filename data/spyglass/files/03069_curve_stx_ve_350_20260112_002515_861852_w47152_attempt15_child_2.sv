`timescale 1ns / 1ps

module curve_stx_ve_350_20260112_002515_861852_w47152_attempt15 (
  input clk, // Added for synthesizable sequential logic
  input rst, // Added for synthesizable reset
  output reg out_data
);

  // Using a parameter for width makes it easy to adjust and ensures explicit width declaration.
  parameter COUNTER_WIDTH = 2;
  reg [COUNTER_WIDTH-1:0] internal_counter;

  // State machine to mimic the initial block's sequential behavior in a synthesizable way.
  reg [1:0] state;
  
  parameter IDLE = 2'b00;
  parameter S1   = 2'b01;
  parameter S2   = 2'b10;
  parameter DONE = 2'b11;

  // Temporary regs to hold next values for non-blocking assignments
  reg [COUNTER_WIDTH-1:0] next_internal_counter;
  reg next_out_data;
  reg [1:0] next_state;

  // Combinational logic for next state and next values
  always @(*) begin
    next_state = state;
    next_internal_counter = internal_counter;
    next_out_data = out_data; // Default: hold current values

    case (state)
      IDLE: begin
        // Initialize internal counter and output as done in the initial block
        // These are the values before any increments, matching the state at time 0.
        next_internal_counter = {COUNTER_WIDTH{1'b0}};
        next_out_data = 1'b0;
        next_state = S1; // Prepare for the first increment on the next clock
      end
      S1: begin
        // Mimics the first '#1; internal_counter = internal_counter + 1; out_data = internal_counter[0];'
        // The increment happens one clock cycle after IDLE.
        next_internal_counter = internal_counter + 1;
        next_out_data = (internal_counter + 1)[0]; // out_data takes the value after increment
        next_state = S2; // Prepare for the second increment on the next clock
      end
      S2: begin
        // Mimics the second '#1; internal_counter = internal_counter + 1; out_data = internal_counter[1];'
        // The second increment happens one clock cycle after S1.
        next_internal_counter = internal_counter + 1;
        next_out_data = (internal_counter + 1)[1]; // out_data takes the value after increment
        next_state = DONE; // Transition to DONE after completing the sequence
      end
      DONE: begin
        // Stay in DONE state, holding final values, mimicking the initial block's end state.
        next_state = DONE;
      end
      default: begin
        // Fallback for undefined states, resetting to a known state
        next_state = IDLE;
        next_internal_counter = {COUNTER_WIDTH{1'b0}};
        next_out_data = 1'b0;
      end
    endcase
  end

  // Sequential logic for state, counter, and output registers
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      internal_counter <= {COUNTER_WIDTH{1'b0}};
      out_data <= 1'b0;
    end else begin
      state <= next_state;
      internal_counter <= next_internal_counter;
      out_data <= next_out_data;
    end
  end

endmodule
