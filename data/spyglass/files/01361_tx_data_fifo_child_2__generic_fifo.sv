// Dummy definition for generic_fifo to resolve ErrorAnalyzeBBox linting violation.
// For actual synthesis/simulation, the real generic_fifo module must be provided.
module generic_fifo #(
  parameter DWIDTH = 1,
  parameter AWIDTH = 1,
  parameter REGISTER_READ = 1,
  parameter EARLY_READ = 1,
  parameter CLOCK_CROSSING = 1,
  parameter ALMOST_EMPTY_THRESH = 1,
  parameter ALMOST_FULL_THRESH = 1,
  parameter MEM_TYPE = 0
)(
  input wclk,
  input wrst_n,
  input wen,
  input [DWIDTH-1:0] wdata,
  output wfull,
  output walmost_full,

  input rclk,
  input rrst_n,
  input ren,
  output [DWIDTH-1:0] rdata,
  output rempty,
  output ralmost_empty
);
  // Default assignments for outputs to provide a valid interface for linting.
  // These assignments do not reflect the actual FIFO behavior and are for linting purposes only.
  assign wfull = 1'b0;
  assign walmost_full = 1'b0;
  assign rdata = {DWIDTH{1'b0}};
  assign rempty = 1'b1;
  assign ralmost_empty = 1'b1;

endmodule
