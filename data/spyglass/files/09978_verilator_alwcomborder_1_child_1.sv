module test1(input wire i, output wire o);
  reg a;
  always_comb begin
    a = i;
    o = a;
  end
endmodule
