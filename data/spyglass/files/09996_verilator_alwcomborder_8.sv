module example_08 (
  input logic a,
  output logic y
);
  logic flag;
  always_comb begin
    y = flag;
    flag = (a == 1'b1);
  end
endmodule
