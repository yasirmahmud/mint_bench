module incomplete_case_2;
  reg [2:0] state;
  reg next_state;
  always @* begin
    case (state)
      3'b000: next_state = 1'b0;
      3'b001: next_state = 1'b1;
      3'b010: next_state = 1'b0;
    endcase
  end
endmodule
