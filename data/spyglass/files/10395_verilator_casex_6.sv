module casex_example_06(
  input [1:0] state_in,
  output reg state_out
);
  always @* begin
    casex (state_in)
      2'bx0: state_out = 1'b1;
      2'b0x: state_out = 1'b0;
      default: state_out = 1'b1;
    endcase
  end
endmodule
