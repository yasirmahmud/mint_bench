module repeat_event_example (
  input clk,
  input rst_n,
  input start_pulse,
  output reg [3:0] counter_out
);

  // Internal registers to manage the 4-clock cycle delay
  reg delay_active;
  reg [1:0] delay_cnt; // Counts from 0 to 3 for 4 clock cycles

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_out <= 4'b0;
      delay_active <= 1'b0; // Disable delay counting
      delay_cnt <= 2'b0;     // Reset delay counter
    end else begin
      if (delay_active) begin
        // If delay is active, increment the delay counter
        if (delay_cnt == 2'd3) begin // delay_cnt has reached 3, meaning 4 cycles (0,1,2,3) have passed
          counter_out <= counter_out + 1; // Increment the main counter after 4 cycles
          delay_active <= 1'b0;           // Stop delay counting
          delay_cnt <= 2'b0;              // Reset delay counter
        end else begin
          delay_cnt <= delay_cnt + 1;     // Continue counting cycles
        end
      end else if (start_pulse) begin // If start_pulse is asserted and no delay is active
        delay_active <= 1'b1;         // Activate delay counting
        delay_cnt <= 2'b0;            // Start delay counter from 0
      end
    end
  end

endmodule
