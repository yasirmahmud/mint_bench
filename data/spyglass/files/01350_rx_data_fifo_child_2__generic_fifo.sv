`define RX_DATA_FIFO_AWIDTH 6
`define MEM_AUTO_MEDIUM 0 // Assuming 0 means "auto" memory inference by the generic_fifo

// Stub for generic_fifo to resolve SpyGlass ErrorAnalyzeBBox violation.
// This stub does not implement actual FIFO functionality but provides the module interface
// needed for linting tools to analyze its instantiation without errors.
module generic_fifo #(
  parameter DWIDTH              = 8,
  parameter AWIDTH              = 4,
  parameter REGISTER_READ       = 0,
  parameter EARLY_READ          = 1,
  parameter CLOCK_CROSSING      = 1,
  parameter ALMOST_EMPTY_THRESH = 4,
  parameter MEM_TYPE            = 0
) (
  // Write side
  input                      wclk,
  input                      wrst_n,
  input                      wen,
  input  [DWIDTH-1:0]        wdata,
  output reg                 wfull,
  output reg                 walmost_full,

  // Read side
  input                      rclk,
  input                      rrst_n,
  input                      ren,
  output reg [DWIDTH-1:0]    rdata,
  output reg                 rempty,
  output reg                 ralmost_empty
);
  // Assign dummy values for linting purposes. These values do not reflect
  // actual FIFO behavior but ensure all output ports are driven.
  always @(*) begin
    wfull          = 1'b0;          // Assume not full
    walmost_full   = 1'b0;          // Assume not almost full
    rdata          = {DWIDTH{1'b0}}; // Output all zeros
    rempty         = 1'b1;          // Assume empty
    ralmost_empty  = 1'b1;          // Assume almost empty
  end
endmodule
