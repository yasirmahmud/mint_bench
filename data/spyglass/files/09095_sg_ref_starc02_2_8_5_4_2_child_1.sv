module my_module_ex2 (input a, input b, output reg out);
 always @(*) begin
  case ((a + b)[0]) // Selector explicitly made 1-bit to match SpyGlass's reported width and STARC rule
    1'b0: out = 1'b0; // Case label width changed to 1 to match selector width
    1'b1: out = 1'b1; // Case label width changed to 1 to match selector width
    default: out = 1'b0;
  endcase
 end
endmodule
