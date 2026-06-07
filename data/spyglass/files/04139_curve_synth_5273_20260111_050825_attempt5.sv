module curve_synth_5273_20260111_050825_attempt5 (
    input clk,
    input rst_n,
    input we,           // Write enable
    input [7:0] wa,     // Write address (0 to 255 needs 8 bits)
    input [143:0] wdata, // Write data (144 bits)
    input re,           // Read enable
    input [7:0] ra,     // Read address (0 to 255 needs 8 bits)
    output reg [143:0] rdata_out // Read data output (144 bits)
);

  // This 'reg' array declares a memory named 'DataMem'.
  // It has 256 elements, each 144 bits wide.
  // Total number of bits = 144 * 256 = 36864 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // matching the specific bit count (36864 bits) mentioned in the rule description.
  // This is expected to trigger a SYNTH_5273 violation.
  reg [143:0] DataMem [0:255];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rdata_out <= 144'b0; // Reset read output
    end else begin
      if (we) begin
        DataMem[wa] <= wdata; // Synchronous write operation
      end
      if (re) begin
        rdata_out <= DataMem[ra]; // Registered synchronous read operation
      end
    end
  end

endmodule
