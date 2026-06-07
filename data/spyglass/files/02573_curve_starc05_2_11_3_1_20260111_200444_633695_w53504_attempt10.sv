module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt10 (
  input wire clk,
  input wire reset,
  input wire data_in,
  output reg match
);

  // Define states for a simple '11' sequence detector FSM
  localparam [1:0]
    STATE_IDLE = 2'b00,
    STATE_ONE  = 2'b01, // Seen '1'
    STATE_TWO  = 2'b10; // Seen '11' sequence detected

  // FSM state register
  reg [1:0] current_state;

  // This always block describes both the sequential part (state register update on posedge clk)
  // and the combinational part (next-state and output logic based on current_state and data_in).
  // This combination within a single always block triggers the STARC05-2.11.3.1 violation.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= STATE_IDLE; // Sequential reset for state
      match         <= 1'b0;       // Sequential reset for output
    end else begin
      // Combinational next-state and output logic based on current state and inputs
      case (current_state) // This 'case' statement is part of the combinational logic
        STATE_IDLE: begin
          if (data_in) begin       // Combinational condition
            current_state <= STATE_ONE; // Next state assignment (sequential part)
            match         <= 1'b0;    // Output assignment (sequential part)
          end else begin
            current_state <= STATE_IDLE;
            match         <= 1'b0;
          end
        end
        STATE_ONE: begin // Waiting for second '1' after first '1'
          if (data_in) begin
            current_state <= STATE_TWO; // '11' detected
            match         <= 1'b1;     // Set output high
          end else begin
            current_state <= STATE_IDLE; // If '0', reset sequence
            match         <= 1'b0;
          end
        end
        STATE_TWO: begin // Sequence '11' was detected in the previous cycle, reset FSM
          current_state <= STATE_IDLE; // Go back to IDLE to detect next sequence
          match         <= 1'b0;       // Clear output after one cycle
        end
        default: begin // Default case to handle X/Z or undefined states
          current_state <= STATE_IDLE;
          match         <= 1'b0;
        end
      endcase
    end
  end

endmodule
