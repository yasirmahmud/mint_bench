module example_04 (
  input logic a,
  output logic y
);
  logic val;
  always_comb begin
    val = ~a; // Assign 'val' first
    y = val & a; // Then use the newly assigned 'val'
  end
endmodule
