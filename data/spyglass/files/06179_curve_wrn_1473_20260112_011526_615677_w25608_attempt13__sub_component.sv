// This module defines a basic component with a real parameter.
// It will be instantiated in the top module.
module sub_component (
  input wire s_in,
  output wire s_out
);
  // This parameter exists, but it's not the one we'll attempt to modify via defparam.
  parameter EXISTING_PARAM = 8'd10;

  // Minimal logic to prevent unused signal warnings
  assign s_out = s_in;
endmodule
