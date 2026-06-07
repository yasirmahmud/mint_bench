module repeat_event_example (
  input clk,
  input rst_n,
  input start_pulse,
  output reg [3:0] counter_out
);

  // Internal registers to manage the 4-clock cycle delay
  reg delay_active;
  reg [1:0] delay_cnt; // Counts from 0 to 3 for 4 clock cycles

  // Next-state signals for combinational logic
  wire delay_active_next;
  wire [1:0] delay_cnt_next;
  wire [3:0] counter_out_next;

  // Combinational next-state logic for the FSM
  always_comb begin
    // Default assignments to prevent latches and maintain current state if no condition met
    delay_active_next = delay_active;
    delay_cnt_next = delay_cnt;
    counter_out_next = counter_out;

    if (delay_active) begin
      // If delay is active, increment the delay counter
      if (delay_cnt == 2'd3) begin // delay_cnt has reached 3, meaning 4 cycles (0,1,2,3) have passed
        counter_out_next = counter_out + 1; // Increment the main counter after 4 cycles
        delay_active_next = 1'b0;           // Stop delay counting
        delay_cnt_next = 2'b0;              // Reset delay counter
      end else begin
        delay_cnt_next = delay_cnt + 1;     // Continue counting cycles
      end
    end else if (start_pulse) begin // If start_pulse is asserted and no delay is active
      delay_active_next = 1'b1;         // Activate delay counting
      delay_cnt_next = 2'b0;            // Start delay counter from 0
    end
  end

  // Sequential update logic for registers
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_out <= 4'b0;
      delay_active <= 1'b0; // Disable delay counting
      delay_cnt <= 2'b0;     // Reset delay counter
    end else begin
      counter_out <= counter_out_next;
      delay_active <= delay_active_next;
      delay_cnt <= delay_cnt_next;
    end
  end

endmodule
