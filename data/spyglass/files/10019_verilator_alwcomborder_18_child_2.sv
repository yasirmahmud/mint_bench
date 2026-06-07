module example_18 (
  input a,
  output reg y
);
  reg data_out_reg;
  always_comb begin
    data_out_reg = a;
    y = a; // Directly assign y from 'a' to prevent potential ALWCOMBORDER read-before-write issues
  end
endmodule
