module test2(input logic i1, i2, output logic o);
  logic a, b;
  always_comb begin
    o = b; // 'b' is used before it's assigned
    b = a; // 'a' is used before it's assigned
    a = i1 & i2;
  end
endmodule
