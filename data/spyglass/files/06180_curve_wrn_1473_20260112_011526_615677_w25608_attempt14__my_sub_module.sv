// This module contains a parameter that is not directly involved in the violation.
module my_sub_module (
  input wire sub_in,
  output wire sub_out
);
  parameter EXISTING_PARAM = 8'd10; // This parameter exists, but is not the target of defparam

  // Minimal logic to prevent unused signal warnings
  assign sub_out = sub_in;
endmodule
