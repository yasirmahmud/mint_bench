module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt9 (
  input wire clk,
  input wire reset,
  input wire data_in,
  output reg match
);

  // Define states for a simple 101 sequence detector FSM
  localparam [1:0]
    STATE_IDLE = 2'b00,
    STATE_S1   = 2'b01, // Seen '1'
    STATE_S2   = 2'b10; // Seen '10'

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
            current_state <= STATE_S1; // Next state assignment (sequential part)
            match         <= 1'b0;    // Output assignment (sequential part)
          end else begin
            current_state <= STATE_IDLE;
            match         <= 1'b0;
          end
        end
        STATE_S1: begin // Waiting for '0' after '1'
          if (!data_in) begin
            current_state <= STATE_S2;
            match         <= 1'b0;
          end else begin
            current_state <= STATE_S1;
            match         <= 1'b0;
          end
        end
        STATE_S2: begin // Waiting for '1' after '10'
          if (data_in) begin
            current_state <= STATE_IDLE;
            match         <= 1'b1; // Sequence '101' detected, set output high
          end else begin
            current_state <= STATE_IDLE;
            match         <= 1'b0;
          end
        end
        default: begin // Handles unreachable states; defaults to IDLE
          current_state <= STATE_IDLE;
          match         <= 1'b0;
        end
      endcase
    end
  end

endmodule
