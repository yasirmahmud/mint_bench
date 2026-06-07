module example_14 (
  input logic a,
  output logic y
);
  logic buffer_var;
  always_comb begin
    // Verilator ALWCOMBORDER fix: Ensure 'buffer_var' is assigned before 'y' reads it.
    // This prevents a simulation-synthesis mismatch and ensures 'y' reflects 'a' immediately.
    buffer_var = a;
    y = buffer_var;
  end
endmodule
