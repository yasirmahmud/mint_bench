// Dummy module to resolve ErrorAnalyzeBBox for KeyExpantion
module KeyExpantion (
  input [127:0] kin,
  output [127:0] kout,
  input [7:0] rcon
);
  // Placeholder logic for linting purposes; actual logic is external.
  assign kout = kin;
endmodule
