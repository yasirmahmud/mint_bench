module curve_synth_5273_20260111_192616_180174_w36056_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire [9:0] addr_in,      // Address width for 576 locations (2^10 = 1024 addresses, covering 0 to 575)
  input wire [63:0] data_in,    // Data width 64 bits
  input wire write_en,
  output reg [63:0] data_out    // Output data width 64 bits
);

  // SYNTH_5273: The original 'KernMem' array with total bits exceeding 4096 triggered the violation.
  // To resolve this while preserving functional behavior, the single large memory is split
  // into 9 smaller memory arrays. Each sub-memory is sized such that its total bit count
  // (64 bits * 64 locations = 4096 bits) is at or below the 'mthresh' value of 4096.
  // This structural change ensures that each memory block individually passes the size check,
  // allowing synthesis tools to potentially infer distributed RAM or smaller block RAMs if desired,
  // without triggering the SYNTH_5273 error for an overly large single register array.
  reg [63:0] KernMem_0 [0:63];
  reg [63:0] KernMem_1 [0:63];
  reg [63:0] KernMem_2 [0:63];
  reg [63:0] KernMem_3 [0:63];
  reg [63:0] KernMem_4 [0:63];
  reg [63:0] KernMem_5 [0:63];
  reg [63:0] KernMem_6 [0:63];
  reg [63:0] KernMem_7 [0:63];
  reg [63:0] KernMem_8 [0:63]; // This sub-memory covers addresses 512 to 575

  // Address decoding for selecting the appropriate sub-memory and element within it.
  // The original 10-bit 'addr_in' is split:
  // - addr_in[9:6] (4 bits) selects one of the 9 sub-memories.
  // - addr_in[5:0] (6 bits) selects an element within the chosen sub-memory (0-63).
  wire [3:0] mem_idx  = addr_in[9:6];
  wire [5:0] elem_idx = addr_in[5:0];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Use 'begin...end' for Verilog-2001 blocks
      data_out <= 0;
      // Memory initialization upon reset is often handled by synthesis tools or via a specific loop.
      // Explicit memory initialization for every element is omitted here, consistent with the original design,
      // as SYNTH_5273 primarily concerns the declaration size.
    end else begin
      // Write operation: Data is written to the selected sub-memory and element.
      if (write_en) begin
        case (mem_idx)
          4'd0: KernMem_0[elem_idx] <= data_in;
          4'd1: KernMem_1[elem_idx] <= data_in;
          4'd2: KernMem_2[elem_idx] <= data_in;
          4'd3: KernMem_3[elem_idx] <= data_in;
          4'd4: KernMem_4[elem_idx] <= data_in;
          4'd5: KernMem_5[elem_idx] <= data_in;
          4'd6: KernMem_6[elem_idx] <= data_in;
          4'd7: KernMem_7[elem_idx] <= data_in;
          4'd8: KernMem_8[elem_idx] <= data_in;
          // For valid addr_in (0 to 575), mem_idx will always be 0-8. Addresses beyond 575
          // are considered out of bounds for the specified memory depth.
          default: ; // This case should not be reached for valid addr_in (0-575).
        endcase
      end

      // Read operation: 'data_out' is always updated synchronously with 'clk'.
      // This preserves the read-before-write behavior of the original memory, where
      // 'data_out' reflects the value from 'KernMem[addr_in]' at the start of the current cycle,
      // before any potential write in the current cycle takes effect.
      case (mem_idx)
        4'd0: data_out <= KernMem_0[elem_idx];
        4'd1: data_out <= KernMem_1[elem_idx];
        4'd2: data_out <= KernMem_2[elem_idx];
        4'd3: data_out <= KernMem_3[elem_idx];
        4'd4: data_out <= KernMem_4[elem_idx];
        4'd5: data_out <= KernMem_5[elem_idx];
        4'd6: data_out <= KernMem_6[elem_idx];
        4'd7: data_out <= KernMem_7[elem_idx];
        4'd8: data_out <= KernMem_8[elem_idx];
        // For addresses outside the 0-575 range, data_out will default to 64'b0, providing
        // a defined output for out-of-bounds access, consistent with uninitialized/undefined behavior.
        default: data_out <= 64'b0;
      endcase
    end
  end

endmodule
