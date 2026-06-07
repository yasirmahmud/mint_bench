module curve_synth_5273_20260111_192616_180174_w36056_attempt7 (
  input wire clk,
  input wire rst_n,
  output reg [63:0] data_out
);

  // SYNTH_5273: The variable 'KernMem' is declared with 64 * 576 = 36864 bits,
  // which is significantly greater than the typical 'mthresh' value of 4096.
  // This will trigger the SYNTH_5273 violation as described in the rule.
  reg [63:0] KernMem[0:575]; // Total bits = 36864

  // Minimal usage to avoid 'unused signal' warnings for all ports and KernMem.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 64'h0;
      KernMem[0] <= 64'h0; // Write to a memory element
    end else begin
      data_out <= KernMem[1]; // Read from a memory element
    end
  end

endmodule
