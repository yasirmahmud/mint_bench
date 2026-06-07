module casex_example_12(
  input [1:0] mode,
  output reg active
);
  always @* begin
    casex (mode)
      2'bx1: active = 1'b1;
      2'b0x: active = 1'b0;
    endcase
  end
endmodule
