module test_real_naming_violation_1 (
    output [63:0] my_real_out
);
  reg [63:0] my_real_var_bits;

  assign my_real_out = my_real_var_bits;

  initial begin
    my_real_var_bits = 64'h40091EB851EB851F; // Represents 3.14 (IEEE 754 double-precision)
  end
endmodule
