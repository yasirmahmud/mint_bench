module pulse_generator  (
  input clk_in,
  input repeated, // Specify if the pulse should be generated repeatedly
  output reg pulse
  );

  parameter INITIAL_VALUE=0; // Define the initial value for the pulse, either 0 or 1; The pulse logic level will be a flip over the initial value
  parameter WAIT_CYCLES=0; // Define the number of clock cycles to wait before the pulse is applied
  parameter PULSE_WIDTH=1; // Define the length of the pulse width 
  parameter PULSE_COUNTER_SIZE=10; // Define the size of the pulse width counter
  
  // Calculate wait_cycle_counter width safely
  localparam WAIT_COUNTER_BITS = (WAIT_CYCLES == 0) ? 1 : $clog2(WAIT_CYCLES + 1);
  reg [WAIT_COUNTER_BITS - 1 : 0] wait_cycle_counter;
  
  reg [PULSE_COUNTER_SIZE - 1 : 0] pulse_width_counter;
  
  reg wait_done; // Flag to indicate completion of the wait phase
  reg pulse_running; // Flag to indicate if the overall pulse train is active (after wait_done)
  reg pulse_output_active; // Flag to indicate if pulse should be ~INITIAL_VALUE for the current cycle

`ifdef VIVADO_SYNTHESIS
  initial begin
    pulse <= INITIAL_VALUE;
    wait_done <= 1'b0;
    pulse_running <= 1'b0;
    pulse_output_active <= 1'b0;
    wait_cycle_counter <= 0;
    pulse_width_counter <= 0;
  end
`endif
  
  // Combine all sequential logic into a single always @(posedge clk_in) block
  always @(posedge clk_in) begin
    // --- State update for wait phase ---
    if (~wait_done) begin
      if (wait_cycle_counter == WAIT_CYCLES) begin
        wait_done <= 1'b1;       // Wait period done
        pulse_running <= 1'b1;  // Start the pulse generation sequence
      end else begin
        wait_cycle_counter <= wait_cycle_counter + 1;
      end
    end

    // --- State update for pulse generation phase ---
    if (wait_done && pulse_running) begin // If wait is done and pulse train is active
      if (PULSE_WIDTH == 0) begin
        // Special case: If PULSE_WIDTH is 0, no pulse should be generated.
        // Stop the pulse sequence immediately.
        pulse_output_active <= 1'b0;
        pulse_running <= 1'b0;
        pulse_width_counter <= 0;
      end else if (pulse_width_counter < PULSE_WIDTH) begin
        // Currently within the pulse width duration
        pulse_output_active <= 1'b1; // Output the inverted value
        pulse_width_counter <= pulse_width_counter + 1;
      end else begin // pulse_width_counter == PULSE_WIDTH, current pulse cycle just ended
        // End of a single pulse cycle within the train
        if (~repeated) begin
          pulse_output_active <= 1'b0; // Turn off pulse output
          pulse_running <= 1'b0;    // Stop the entire pulse train (non-repeated)
        end else begin // repeated is true
          // Continue the pulse train, start the next pulse immediately
          pulse_output_active <= 1'b1; // Pulse remains active for the next cycle
          pulse_width_counter <= 0;   // Reset counter for the next pulse repetition
        end
      end
    end else if (~wait_done) begin
      // Reset pulse-related flags and counter while in the waiting phase
      pulse_running <= 1'b0;
      pulse_output_active <= 1'b0;
      pulse_width_counter <= 0;
    end
    
    // Ensure pulse_width_counter is reset if the pulse train is not running
    if (!pulse_running) begin
      pulse_width_counter <= 0;
    end

    // --- Output 'pulse' logic (single assignment to resolve W415a/STARC05-2.2.3.3) ---
    if (pulse_output_active) begin
      pulse <= ~INITIAL_VALUE;
    end else begin
      pulse <= INITIAL_VALUE;
    end
  end
  
endmodule
