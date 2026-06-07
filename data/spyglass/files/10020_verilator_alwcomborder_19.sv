module example_19 (
  input logic a,
  output logic y
);
  logic next_state;
  always_comb begin
    y = next_state;
    next_state = a;
  end
endmodule
