module curve_w263_20260111_155453_471069_w11684_attempt5 (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    output reg [2:0] state_out
);

  // Selector will be 3 bits wide
  reg [2:0] current_state;
  reg [2:0] next_state;

  // Define states using parameters
  parameter S_IDLE  = 3'b000; // 3 bits - matches selector
  parameter S_LOAD  = 3'b001; // 3 bits - matches selector
  parameter S_ERROR = 1'b1;   // This parameter's value is 1 bit wide, creating the violation
  parameter S_DONE  = 3'b011; // 3 bits - matches selector

  // State register update
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state <= S_IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic and output logic
  always @* begin
    next_state = current_state; // Default assignment to avoid latch
    state_out = current_state;  // Output current state

    case (current_state) // Selector 'current_state' is 3 bits wide
      S_IDLE: begin // S_IDLE is 3'b000, width 3 - Matches selector width
        if (data_in) next_state = S_LOAD;
        else next_state = S_IDLE;
      end
      S_LOAD: begin // S_LOAD is 3'b001, width 3 - Matches selector width
        if (data_in) next_state = S_DONE;
        else next_state = S_ERROR; // Transition to the state with mismatched width
      end
      // W263 violation occurs here:
      // Case label 'S_ERROR' (value 1'b1, width 1) does not match selector 'current_state' (width 3).
      S_ERROR: begin
        next_state = S_IDLE; // Loop back or go to a recovery state
      end
      S_DONE: begin // S_DONE is 3'b011, width 3 - Matches selector width
        next_state = S_IDLE;
      end
      default: begin // Default case to cover all possibilities for a 3-bit selector and prevent latches
        next_state = S_IDLE;
      end
    endcase
  end

endmodule
