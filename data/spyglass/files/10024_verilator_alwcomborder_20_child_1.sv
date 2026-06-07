module example_20 (
  input logic a,
  output logic y
);
  logic current_val;
  always_comb begin
    // Verilator ALWCOMBORDER: This warning indicates that 'current_val' is read by 'y' before it is assigned a new value 'a'
    // within the same always_comb block. To resolve this and ensure consistent behavior across tools,
    // 'current_val' must be assigned before it is used.
    current_val = a; // Assign 'current_val' its new value based on 'a'
    y = current_val; // Then, assign 'y' the (now updated) value of 'current_val'
  end
endmodule
