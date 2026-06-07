module curve_synth_78_20260111_070734_attempt3 (
  input wire clk,
  input wire rst_n,
  input wire enable_i,
  output reg busy_o
);

  // State machine to replace the non-synthesizable 'wait' construct.
  // The original 'wait (enable_i == 1'b0)' within 'if (enable_i)'
  // implies that busy_o should be set to 1'b1 only after enable_i was high
  // and then transitions to low. The 'busy_o <= 1'b0' in the else branch
  // suggests busy_o is only high for a single cycle, when enable_i has just fallen.
  
  reg [1:0] state; // Current state
  
  // Define states for the FSM
  parameter IDLE = 2'b00;             // Default state: busy_o is low. Waiting for enable_i to go high.
  parameter WAITING_FOR_FALL = 2'b01; // enable_i was high, now waiting for it to go low.

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= IDLE;
      busy_o <= 1'b0; // Reset busy_o to low
    end else begin
      case (state)
        IDLE: begin
          if (enable_i) begin
            // If enable_i goes high, transition to WAITING_FOR_FALL state.
            // busy_o remains low during the wait period.
            state <= WAITING_FOR_FALL;
            busy_o <= 1'b0;
          end else begin
            // If enable_i is low, stay in IDLE and keep busy_o low.
            state <= IDLE;
            busy_o <= 1'b0;
          end
        end
        
        WAITING_FOR_FALL: begin
          if (!enable_i) begin
            // If enable_i goes low while in WAITING_FOR_FALL state (wait condition met).
            // Set busy_o high for one cycle and return to IDLE.
            state <= IDLE;
            busy_o <= 1'b1; // busy_o becomes high on this clock edge
          end else begin
            // If enable_i is still high, continue waiting in this state.
            // busy_o remains low during this period.
            state <= WAITING_FOR_FALL;
            busy_o <= 1'b0;
          end
        end
        
        default: begin
          // Should not happen, but a safe default.
          state <= IDLE;
          busy_o <= 1'b0;
        end
      endcase
    end
  end

endmodule
