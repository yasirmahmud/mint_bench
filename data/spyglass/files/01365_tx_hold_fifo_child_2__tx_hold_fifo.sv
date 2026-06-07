// Original tx_hold_fifo module
module tx_hold_fifo(
  // Outputs
  txhfifo_wfull, txhfifo_walmost_full, txhfifo_rdata, txhfifo_rstatus,
  txhfifo_rempty, txhfifo_ralmost_empty,
  // Inputs
  clk_xgmii_tx, reset_xgmii_tx_n, txhfifo_wdata, txhfifo_wstatus,
  txhfifo_wen, txhfifo_ren
  );

input         clk_xgmii_tx;
input         reset_xgmii_tx_n;

input [63:0]  txhfifo_wdata;
input [7:0]   txhfifo_wstatus;
input         txhfifo_wen;

input         txhfifo_ren;

output        txhfifo_wfull;
output        txhfifo_walmost_full;

output [63:0] txhfifo_rdata;
output [7:0]  txhfifo_rstatus;
output        txhfifo_rempty;
output        txhfifo_ralmost_empty;

// Temporary wire to hold the combined output data from the FIFO
// This is used to correctly split the 72-bit FIFO output into 8-bit status and 64-bit data.
wire [71:0] fifo_rdata_combined;

generic_fifo #(
  .DWIDTH (72),                       // Combined data width: 64-bit data + 8-bit status
  .AWIDTH (`TX_HOLD_FIFO_AWIDTH),    // Address width, defined as 5 (32 entries)
  .REGISTER_READ (1),               // Read data is registered
  .EARLY_READ (1),                  // Read flags are based on state before current read
  .CLOCK_CROSSING (0),              // Synchronous FIFO
  .ALMOST_EMPTY_THRESH (7),
  .ALMOST_FULL_THRESH (4),
  .MEM_TYPE (`MEM_AUTO_SMALL)
)
fifo0(
    .wclk (clk_xgmii_tx),
    .wrst_n (reset_xgmii_tx_n),
    .wen (txhfifo_wen),
    .wdata ({txhfifo_wstatus, txhfifo_wdata}), // Concatenate status (MSBs) and data (LSBs) for write
    .wfull (txhfifo_wfull),
    .walmost_full (txhfifo_walmost_full),

    .rclk (clk_xgmii_tx),
    .rrst_n (reset_xgmii_tx_n),
    .ren (txhfifo_ren),
    .rdata (fifo_rdata_combined),   // Connect fifo's output to the combined wire
    .rempty (txhfifo_rempty),
    .ralmost_empty (txhfifo_ralmost_empty)
);

// Split the combined FIFO output into individual status and data outputs
assign txhfifo_rstatus = fifo_rdata_combined[71:64]; // Upper 8 bits are status
assign txhfifo_rdata   = fifo_rdata_combined[63:0];  // Lower 64 bits are data

endmodule
