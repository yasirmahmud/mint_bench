module curve_wrn_1452_20260111_220916_359402_w15680_attempt12 (
  my_input,
  my_output
);

  // Non-ANSI style port declarations
  input [7:0] my_input;    // Port 'my_input' initially declared as an 8-bit input
  output [3:0] my_output;  // Port 'my_output' declared as a 4-bit output

  // WRN_1452 Violation:
  // 'my_input' is re-declared as a 4-bit wire. This is inconsistent with its
  // initial 8-bit declaration in the port list, triggering WRN_1452.
  wire [3:0] my_input; // Inconsistent range re-declaration for 'my_input'

  // Assign a value to 'my_output' to prevent unused signal warnings.
  // The re-declared 4-bit 'my_input' is used here.
  assign my_output = my_input;

endmodule
