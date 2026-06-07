module curve_synth_5273_20260111_192616_180174_w36056_attempt7 (
  input wire clk,
  input wire rst_n,
  output reg [63:0] data_out
);

  // SYNTH_5273 violation: The original KernMem (64 * 576 = 36864 bits) was too large.
  // It is reduced to 2 elements (64 * 2 = 128 bits) as only KernMem[0] and KernMem[1] are used.
  reg [63:0] KernMem[0:1]; // Reduced array size to resolve SYNTH_5273

  // Minimal usage to avoid 'unused signal' warnings for all ports and KernMem.
  // The original usage caused W123 (read but never set for KernMem[1]) and
  // W528 (set but not read for KernMem[0]). These are resolved by ensuring
  // both elements are read and written.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 64'h0;
      KernMem[0] <= 64'h0; // Write to a memory element
      KernMem[1] <= 64'h0; // Initialize KernMem[1] to resolve W123 (read but never set)
    end else begin
      KernMem[1] <= KernMem[0]; // Read KernMem[0] to resolve W528 (set but not read) and update KernMem[1]
      data_out <= KernMem[1];   // Read from KernMem[1]
    end
  end

endmodule
