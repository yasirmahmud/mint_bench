module curve_synth_5273_20260111_192616_180174_w36056_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire [9:0] addr_in,      // Address width for 576 locations (2^10 = 1024 addresses, covering 0 to 575)
  input wire [63:0] data_in,    // Data width 64 bits
  input wire write_en,
  output reg [63:0] data_out    // Output data width 64 bits
);

  // SYNTH_5273: Declare a memory array with total bits exceeding 4096.
  // The array 'KernMem' has a data width of 64 bits and an address depth of 576 locations (from 0 to 575).
  // Total bits = 64 * 576 = 36864 bits.
  // This value (36864) is significantly greater than the typical 'mthresh' option value of 4096,
  // directly triggering the SYNTH_5273 violation for the 'KernMem' variable as described in the rule.
  reg [63:0] KernMem [0:575];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Use 'begin...end' for Verilog-2001 blocks
      data_out <= 0;
      // Memory initialization upon reset is often handled by synthesis tools or via a specific loop.
      // For minimalism and to avoid triggering other rules, explicit memory initialization for
      // every element is omitted here, as the SYNTH_5273 rule primarily concerns the declaration size.
    end else begin
      if (write_en) begin
        KernMem[addr_in] <= data_in; // Write operation: store data into KernMem at addr_in
      end
      // Read operation always occurs, ensuring 'data_out' is driven and
      // 'KernMem' is read, which helps prevent unused signal warnings.
      data_out <= KernMem[addr_in];
    end
  end

endmodule
