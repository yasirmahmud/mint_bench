module curve_synth_5273_20260111_050825_attempt4 (
    input clk,
    input rst_n,
    input we,           // Write enable
    input [9:0] wa,     // Write address (0 to 575 needs 10 bits)
    input [63:0] wdata, // Write data
    input re,           // Read enable
    input [9:0] ra,     // Read address (0 to 575 needs 10 bits)
    output reg [63:0] rdata_out // Read data output
);

  // This 'reg' array declares a memory named 'KernMem'.
  // It has 576 elements, each 64 bits wide.
  // Total number of bits = 64 * 576 = 36864 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // matching the specific bit count (36864 bits) mentioned in the rule description.
  // This is expected to trigger a SYNTH_5273 violation.
  reg [63:0] KernMem [0:575];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rdata_out <= 64'b0; // Reset read output
    end else begin
      if (we) begin
        KernMem[wa] <= wdata; // Write operation
      end
      if (re) begin
        rdata_out <= KernMem[ra]; // Registered read operation
      end
    end
  end

endmodule
