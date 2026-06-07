module test1(input logic i, output logic o);
  logic a;
  always_comb begin
    o = a; // 'a' is used before it's assigned
    a = i;
  end
endmodule
