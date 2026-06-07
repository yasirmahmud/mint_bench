module unequal_cmp_1;
  reg [3:0] a;
  reg [1:0] b;
  wire result;

  initial begin
    a = 4'hA;
    b = 2'h2;
    result = (a == b); // LHS is 4 bits, RHS is 2 bits
    $display("Result 1: %b", result);

    a = 4'h2;
    b = 2'h2;
    result = (a == b); // LHS is 4 bits, RHS is 2 bits
    $display("Result 2: %b", result);
  end
endmodule
