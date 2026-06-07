module test2(input wire i1, input wire i2, output reg o);
  always_comb begin
    o = i1 & i2;
  end
endmodule
