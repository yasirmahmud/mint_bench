module curve_synth_78_20260111_224340_552564_w49296_attempt12 (
  input clk,
  input rst_n,
  input trigger_in,
  input data_ready_sig,
  output reg flag_out
);

  // State register for the flag's behavior
  // 0: IDLE state (flag_out is low, waiting for trigger_in)
  // 1: WAIT_DATA state (flag_out is high, waiting for data_ready_sig)
  reg current_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= 1'b0; // Reset to IDLE state
      flag_out <= 1'b0;     // Reset flag_out to low
    end else begin
      // Logic to determine the next state and next flag_out value
      reg next_state;
      reg next_flag_out;

      // Default values to ensure all paths assign to next_state and next_flag_out
      next_state = current_state;
      next_flag_out = 1'b0; // Default flag_out to low unless specified otherwise

      case (current_state) 
        1'b0: begin : IDLE_STATE // IDLE state: flag_out is low, waiting for trigger
          if (trigger_in) begin
            // Trigger received, move to WAIT_DATA state and assert flag_out
            next_state = 1'b1; 
            next_flag_out = 1'b1;
          end else begin
            // No trigger, stay in IDLE state
            next_state = 1'b0; 
            next_flag_out = 1'b0; // Explicitly keep flag_out low
          end
        end

        1'b1: begin : WAIT_DATA_STATE // WAIT_DATA state: flag_out is high, waiting for data_ready
          if (data_ready_sig) begin
            // Data is ready, move back to IDLE state and deassert flag_out
            next_state = 1'b0;
            next_flag_out = 1'b0; // Explicitly set flag_out low
          end else begin
            // Data not ready, stay in WAIT_DATA state and keep flag_out high
            next_state = 1'b1;
            next_flag_out = 1'b1; // Explicitly keep flag_out high
          end
        end

        default: begin // Should not happen with 1-bit state, but good practice
          next_state = 1'b0; 
          next_flag_out = 1'b0;
        end
      endcase

      // Update state and output register at the clock edge
      current_state <= next_state;
      flag_out <= next_flag_out;
    end
  end

endmodule
