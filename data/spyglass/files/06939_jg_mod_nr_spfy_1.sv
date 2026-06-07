module mod_nr_spfy_example1 (
  input a,
  output reg b
);

  always @(a) begin
    b = a;
  end

  specify
    (a => b) = (1, 2); // Non-synthesizable specify block
  endspecify

endmodule
