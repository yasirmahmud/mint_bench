module curve_stx_ve_350_20260112_002515_861852_w47152_attempt14_child_2 (
  input clk,
  input rst_n,
  output reg status_flag
);

  reg internal_toggle_val;
  reg [3:0] delay_cnt; // Counter for the 10-cycle delays
  reg [1:0] state;

  // State definitions for the sequence
  localparam S_IDLE = 2'b00;             // Initial state where values are set to 0
  localparam S_DELAY1_ACTIVE = 2'b01;    // Waiting for the first #10 delay
  localparam S_TOGGLE_AND_DELAY2 = 2'b10; // Values toggled, waiting for the second #10 delay
  localparam S_FINAL = 2'b11;            // Final state where status_flag is 0

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Asynchronous reset to initial state
      internal_toggle_val <= 1'b0;
      status_flag <= 1'b0;
      delay_cnt <= 4'b0;
      state <= S_IDLE;
    end else begin
      case (state)
        S_IDLE: begin
          // Replicate the initial assignments from the original 'initial' block
          // internal_toggle_val is already 0 from reset
          status_flag <= internal_toggle_val; // Will be 0
          delay_cnt <= 4'b0;
          state <= S_DELAY1_ACTIVE; // Move to the first delay phase
        end

        S_DELAY1_ACTIVE: begin
          // Count 10 clock cycles for the first delay
          if (delay_cnt == 4'd9) begin // Counted 10 cycles (0 to 9)
            delay_cnt <= 4'b0;
            // Replicate the operations after the first #10 delay
            internal_toggle_val <= ~internal_toggle_val; // Toggle internal value (0 -> 1)
            status_flag <= ~internal_toggle_val;        // Update output based on new internal value (0 -> 1)
            state <= S_TOGGLE_AND_DELAY2; // Move to the next phase
          end else begin
            delay_cnt <= delay_cnt + 4'b1;
          end
        end

        S_TOGGLE_AND_DELAY2: begin
          // Count 10 clock cycles for the second delay
          if (delay_cnt == 4'd9) begin
            delay_cnt <= 4'b0;
            // Replicate the operations after the second #10 delay
            status_flag <= 1'b0; // Final state for output
            state <= S_FINAL;    // Move to the final state
          end else begin
            delay_cnt <= delay_cnt + 4'b1;
          end
        end

        S_FINAL: begin
          // Stay in this state, ensuring status_flag remains 0
          status_flag <= 1'b0;
        end

        default: begin
          // Should not happen, but for robustness
          state <= S_IDLE;
        end
      endcase
    end
  end

endmodule
