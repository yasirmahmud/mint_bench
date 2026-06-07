module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt8 (
  input wire clk,
  input wire reset,
  input wire start_button,
  input wire stop_button,
  output reg busy_indicator
);

  // Define states for a simple FSM
  localparam [0:0] // Using 1-bit states for minimal width
    STATE_IDLE   = 1'b0,
    STATE_ACTIVE = 1'b1;

  // State register
  reg [0:0] current_state;

  // This always block contains both sequential (FF assignments) and combinational (next-state/output logic)
  // parts for the FSM, causing the STARC05-2.11.3.1 violation.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= STATE_IDLE;   // Sequential reset for current_state
      busy_indicator <= 1'b0;        // Sequential reset for output
    end else begin
      // The 'if-else if' structure here defines the combinational next-state and output logic.
      // Since it's placed inside the sequential block and directly assigns to 'current_state' and 'busy_indicator',
      // it triggers the violation.
      if (current_state == STATE_IDLE) begin
        if (start_button) begin
          current_state <= STATE_ACTIVE; // Next state assignment (sequential part)
          busy_indicator <= 1'b1;        // Output assignment (sequential part)
        end else begin
          current_state <= STATE_IDLE;   // Next state assignment (sequential part)
          busy_indicator <= 1'b0;        // Output assignment (sequential part)
        end
      end else if (current_state == STATE_ACTIVE) begin
        if (stop_button) begin
          current_state <= STATE_IDLE;   // Next state assignment (sequential part)
          busy_indicator <= 1'b0;        // Output assignment (sequential part)
        end else begin
          current_state <= STATE_ACTIVE; // Next state assignment (sequential part)
          busy_indicator <= 1'b1;        // Output assignment (sequential part)
        end
      end
      // All possible states and paths assign to 'current_state' and 'busy_indicator', preventing latches.
    end
  end

endmodule
