module curve_w263_20260111_155453_471069_w11684_attempt4 (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    output reg [1:0] state_out
);

  // Selector will be 2 bits wide
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Define states using parameters
  parameter S0 = 2'b00; // 2 bits
  parameter S1 = 2'b01; // 2 bits
  parameter S2 = 3'b010; // This parameter's value is 3 bits wide
  parameter S3 = 2'b11; // 2 bits

  // State register update
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic and output logic
  always @* begin
    next_state = current_state; // Default assignment to avoid latch
    state_out = current_state;  // Output current state

    case (current_state) // Selector 'current_state' is 2 bits wide
      S0: begin // S0 is 2'b00, width 2 - Matches selector width
        if (data_in) next_state = S1;
        else next_state = S0;
      end
      S1: begin // S1 is 2'b01, width 2 - Matches selector width
        next_state = S2; // Transition to the state with mismatched width
      end
      S2: begin // W263 expected here: Case label 'S2' (value 3'b010, width 3) does not match selector 'current_state' (width 2).
        next_state = S3;
      end
      S3: begin // S3 is 2'b11, width 2 - Matches selector width
        next_state = S0;
      end
      default: begin // Default case for a 2-bit selector to cover all possibilities and prevent latches
        next_state = S0;
      end
    endcase
  end

endmodule
