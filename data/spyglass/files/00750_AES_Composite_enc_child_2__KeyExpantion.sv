// Dummy module to resolve ErrorAnalyzeBBox for KeyExpantion
module KeyExpantion (
  input [127:0] kin,
  output [127:0] kout,
  input [7:0] rcon
);
  // Placeholder logic for linting purposes; actual logic is external.
  // Resolve W240 by consuming unused inputs without affecting kout for placeholder.
  wire [7:0] dummy_rcon = rcon; // Consumes rcon
  assign kout = kin;
endmodule
