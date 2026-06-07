module curve_synth_5273_20260111_050825_attempt6 (
    input clk,
    input [7:0] addr_in,
    input [143:0] data_in,
    output reg [143:0] data_out
);

  // This 'reg' array declares a memory named 'BigMem'.
  // It has 256 elements, each 144 bits wide.
  // Total number of bits = 144 * 256 = 36864 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096.
  // This declaration is expected to trigger the SYNTH_5273 violation,
  // as 36864 is greater than the default mthresh value.
  reg [143:0] BigMem [0:255];

  always @(posedge clk) begin
    // Synchronous write operation: always write data_in to BigMem[addr_in]
    BigMem[addr_in] <= data_in;
    // Synchronous read operation: register BigMem[addr_in] to data_out
    data_out <= BigMem[addr_in];
  end

endmodule
