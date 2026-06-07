module incomplete_case_no_default_2 (
  input [2:0] state_in,
  output reg [1:0] next_state
);

  always @(state_in) begin
    case (state_in)
      3'b000: next_state = 2'b00;
      3'b001: next_state = 2'b01;
      3'b010: next_state = 2'b10;
      // Missing 3'b011 through 3'b111, and no default
    endcase
  end

endmodule
