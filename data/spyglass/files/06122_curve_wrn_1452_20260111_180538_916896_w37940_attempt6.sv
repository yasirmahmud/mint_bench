module curve_wrn_1452_attempt6 (
    port_a,
    port_b
);

  // Port declarations with specified ranges
  output [7:0] port_a;
  output [3:0] port_b;

  // Inconsistent re-declaration of port_a as a wire with a different range
  // This declaration causes the first WRN_1452 violation for 'port_a'.
  wire [3:0] port_a;

  // Inconsistent re-declaration of port_b as a wire with a different range
  // This declaration causes the second WRN_1452 violation for 'port_b'.
  wire [7:0] port_b;

  // Assignments to avoid unused signal warnings.
  // The assigned widths are chosen to match one of the conflicting declarations 
  // to prevent other width-related warnings.
  assign port_a = 4'hA;
  assign port_b = 4'h5;

endmodule
