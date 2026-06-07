module test2(input wire i1, input wire i2, output reg o);
  reg a, b;
  always_comb begin
    a = i1 & i2;
    b = a;
    o = b;
  end
endmodule
