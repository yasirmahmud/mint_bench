// Dummy module to resolve ErrorAnalyzeBBox for AES_Core_dout
module AES_Core_dout (
  input [127:0] din,
  output [127:0] dout,
  input [127:0] kin,
  input sel
);
  // Placeholder logic for linting purposes; actual logic is external.
  // Resolve W240 by consuming unused inputs without affecting dout for placeholder.
  wire [127:0] dummy_kin = kin; // Consumes kin
  wire dummy_sel = sel;         // Consumes sel
  assign dout = din; 
endmodule
