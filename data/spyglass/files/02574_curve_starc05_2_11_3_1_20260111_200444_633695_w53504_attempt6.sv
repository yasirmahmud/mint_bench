module curve_starc05_2_11_3_1_20260111_200444_633695_w53504_attempt6 (
  input clk,
  input reset,
  input in_sig,
  output reg out_sig
);

  // Define states for a simple FSM
  localparam [1:0]
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10;

  // State register (sequential part of FSM)
  reg [1:0] current_state;
  // Next state logic (intended as combinational, but will be mixed)
  reg [1:0] next_state;

  // This always block contains both sequential and combinational parts for the FSM
  always @(posedge clk) begin
    if (reset) begin
      // Sequential reset for current_state and out_sig
      current_state <= STATE_A;
      out_sig <= 1'b0;
      // Combinational assignment for next_state within the sequential block
      next_state = STATE_A; // VIOLATION: Combinational part for next_state mixed here
    end else begin
      // Sequential update for current_state
      current_state <= next_state;

      // Combinational logic for 'next_state' and sequential update for 'out_sig'
      // These blocking assignments to 'next_state' constitute the combinational part
      // of the FSM logic being defined within a synchronous always block.
      case (current_state)
        STATE_A: begin
          if (in_sig) begin
            next_state = STATE_B; // VIOLATION: Blocking assignment to 'next_state' reg
            out_sig <= 1'b0;
          end else begin
            next_state = STATE_A;
            out_sig <= 1'b0;
          end
        end
        STATE_B: begin
          if (in_sig) begin
            next_state = STATE_C;
            out_sig <= 1'b1;
          end else begin
            next_state = STATE_A;
            out_sig <= 1'b0;
          end
        end
        STATE_C: begin
          next_state = STATE_A;
          out_sig <= 1'b1;
        end
        default: begin
          next_state = STATE_A; // Handle unexpected states
          out_sig <= 1'b0;
        end
      endcase
    end
  end

endmodule
