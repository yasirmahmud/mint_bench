module example_03 (
  input logic a,
  output logic y
);
  logic state;
  always_comb begin
    if (state) y = 1'b1;
    else y = 1'b0;
    state = a;
  end
endmodule
