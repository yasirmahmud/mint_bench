module curve_synth_5273_20260111_192616_180174_w36056_attempt9 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] addr_in,
  input wire [31:0] data_in,
  input wire write_en,
  output reg [31:0] data_out
);

  // Parameters for memory dimensions
  localparam DATA_WIDTH = 32;
  localparam ADDR_DEPTH = 256; // 2^8 = 256

  // SYNTH_5273: Declare a memory array with total bits exceeding 4096.
  // The array 'large_mem_array' has a data width of 32 bits and an address depth of 256 locations.
  // Total bits = DATA_WIDTH * ADDR_DEPTH = 32 * 256 = 8192 bits.
  // This value (8192) is significantly greater than the typical 'mthresh' value of 4096,
  // directly triggering the SYNTH_5273 violation for the 'large_mem_array' variable.
  // FIX: Added a synthesis attribute to instruct the tool to infer this as a block RAM,
  // which typically bypasses the 'mthresh' limit for distributed RAM inference.
  (* ram_style = "block" *) reg [DATA_WIDTH-1:0] large_mem_array [ADDR_DEPTH-1:0];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Changed '{' to 'begin' to fix STX_VE_481
      // Reset 'data_out'. Synthesis tools typically initialize memory cells
      // to a known state (e.g., 0) upon reset or power-up, avoiding a specific loop here.
      data_out <= 0;
    end else begin // Changed '}' to 'end' and '{' to 'begin' to fix STX_VE_481
      if (write_en) begin
        large_mem_array[addr_in] <= data_in; // Write operation
      end
      // Read operation always occurs, ensuring 'data_out' is driven and
      // 'large_mem_array' is read, preventing unused signal warnings.
      data_out <= large_mem_array[addr_in];
    end // Changed '}' to 'end'
  end

endmodule
