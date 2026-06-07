module large_delay_range_seq (
  input clk,
  input rst_n,
  input start_event,
  input end_event,
  output reg violation
);

  // Parameter for the maximum delay (1500 cycles as per the original SVA)
  parameter MAX_DELAY = 1500;
  // Calculate the required bit width for the counter to hold values up to MAX_DELAY
  // $clog2(N) gives the minimum number of bits required to represent N values (0 to N-1).
  // For MAX_DELAY, we need to represent 0 to MAX_DELAY, so MAX_DELAY + 1 total values.
  localparam COUNT_WIDTH = $clog2(MAX_DELAY + 1);

  reg [COUNT_WIDTH-1:0] counter;
  reg waiting_for_end_event; // Flag to indicate if we are currently waiting for 'end_event'

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Asynchronous reset for all registers
      counter <= {COUNT_WIDTH{1'b0}};
      waiting_for_end_event <= 1'b0;
      violation <= 1'b0;
    end else begin
      // Default 'violation' to 0, it will be set to 1 only if a violation is detected in the current cycle
      violation <= 1'b0;

      if (waiting_for_end_event) begin
        // We are currently waiting for 'end_event' after a 'start_event'
        if (end_event) begin // FIX: Replaced '{' with 'begin'
          // 'end_event' occurred, so the property is satisfied
          waiting_for_end_event <= 1'b0; // Stop waiting
          counter <= {COUNT_WIDTH{1'b0}}; // Reset counter
        end else if (counter == MAX_DELAY) begin // FIX: Replaced '}' with 'end' and '{' with 'begin'
          // 'end_event' did not occur within MAX_DELAY cycles
          // This is a violation of the property
          violation <= 1'b1;
          waiting_for_end_event <= 1'b0; // Stop waiting
          counter <= {COUNT_WIDTH{1'b0}}; // Reset counter
        end else begin // FIX: Replaced '}' with 'end' and '{' with 'begin'
          // 'end_event' has not occurred yet, and we are still within the allowed delay range
          counter <= counter + 1; // Increment counter
        end // FIX: Replaced '}' with 'end' to close the 'if (waiting_for_end_event) begin' block properly
      end else begin // !waiting_for_end_event: We are in the IDLE state, waiting for 'start_event'
        if (start_event) begin // FIX: Replaced '{' with 'begin'
          // A 'start_event' has occurred
          if (end_event) begin // FIX: Replaced '{' with 'begin'
            // The 'end_event' also occurred in the same cycle (##0 case). Property satisfied immediately.
            waiting_for_end_event <= 1'b0;
            counter <= {COUNT_WIDTH{1'b0}};
          end else begin // FIX: Replaced '}' with 'end' and '{' with 'begin'
            // 'end_event' did not occur in the same cycle, start waiting for it in subsequent cycles
            waiting_for_end_event <= 1'b1;
            // Counter starts from 1 for the first possible delay (##1, ##2, ...)
            counter <= 1; 
          end // FIX: Replaced '}' with 'end'
        end // FIX: Replaced '}' with 'end'
      end // FIX: Replaced '}' with 'end'
    end
  end

endmodule
