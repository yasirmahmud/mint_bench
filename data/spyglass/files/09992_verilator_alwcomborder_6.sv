module example_06 (
  input logic a,
  output logic y
);
  logic count;
  always_comb begin
    y = count;
    count = a ? 1'b1 : 1'b0;
  end
endmodule
