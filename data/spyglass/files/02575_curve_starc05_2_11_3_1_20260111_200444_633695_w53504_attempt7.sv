module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt7 (
  input wire clk,
  input wire reset,
  input wire in_sig,
  output reg out_sig
);

  // Define states for a simple FSM
  localparam [0:0] // Using 1-bit states for minimal width
    STATE_A = 1'b0,
    STATE_B = 1'b1;

  // State register
  reg [0:0] current_state;

  // This always block contains both sequential and combinational parts for the FSM
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= STATE_A; // Sequential reset for current_state
      out_sig <= 1'b0;          // Sequential reset for output
    end else begin
      // This 'case' statement implements the combinational next-state and output logic
      // It is placed inside the sequential block, causing the STARC05-2.11.3.1 violation.
      case (current_state)
        STATE_A: begin
          if (in_sig) begin
            current_state <= STATE_B; // Next state assignment (sequential part)
            out_sig <= 1'b1;          // Output assignment (sequential part)
          end else begin
            current_state <= STATE_A; // Next state assignment (sequential part)
            out_sig <= 1'b0;          // Output assignment (sequential part)
          end
        end
        STATE_B: begin
          if (in_sig) begin
            current_state <= STATE_A; // Next state assignment (sequential part)
            out_sig <= 1'b0;          // Output assignment (sequential part)
          end else begin
            current_state <= STATE_B; // Next state assignment (sequential part)
            out_sig <= 1'b1;          // Output assignment (sequential part)
          end
        end
        default: begin
          current_state <= STATE_A; // Handle unexpected states (sequential part)
          out_sig <= 1'b0;          // Output assignment (sequential part)
        end
      endcase
    end
  end

endmodule
