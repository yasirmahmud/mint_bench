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

  // To resolve SYNTH_5273 (mthresh violation), the large memory 'KernMem'
  // is split into smaller, mthresh-compliant blocks.
  // Original memory size: 576 words * 64 bits/word = 36864 bits.
  // Given mthresh = 4096 bits, the maximum words per block is 4096 / 64 = 64 words.
  // Number of blocks required = ceil(576 words / 64 words/block) = 9 blocks.
  // Each block will be 64 words x 64 bits = 4096 bits, which is exactly mthresh.

  reg [63:0] KernMem_0 [0:63]; // Block 0: Addresses 0-63
  reg [63:0] KernMem_1 [0:63]; // Block 1: Addresses 64-127
  reg [63:0] KernMem_2 [0:63]; // Block 2: Addresses 128-191
  reg [63:0] KernMem_3 [0:63]; // Block 3: Addresses 192-255
  reg [63:0] KernMem_4 [0:63]; // Block 4: Addresses 256-319
  reg [63:0] KernMem_5 [0:63]; // Block 5: Addresses 320-383
  reg [63:0] KernMem_6 [0:63]; // Block 6: Addresses 384-447
  reg [63:0] KernMem_7 [0:63]; // Block 7: Addresses 448-511
  reg [63:0] KernMem_8 [0:63]; // Block 8: Addresses 512-575 (Last word is KernMem_8[63] for total address 575)

  // Address decomposition for sub-memory selection:
  // The 10-bit address (wa/ra[9:0]) is split into:
  // - [9:6]: 4 bits for selecting one of the 9 memory blocks (values 0-8)
  // - [5:0]: 6 bits for selecting the word index within the chosen block (values 0-63)
  wire [3:0] wa_mem_idx = wa[9:6];   // Memory block index for write address
  wire [5:0] wa_word_idx = wa[5:0]; // Word index within the block for write address

  wire [3:0] ra_mem_idx = ra[9:6];   // Memory block index for read address
  wire [5:0] ra_word_idx = ra[5:0]; // Word index within the block for read address

  // Changed from reg to wire to resolve SYNTH_77 and W505 violations.
  // This wire holds the combinational data read from the selected memory block.
  wire [63:0] read_data_temp;

  // Combinational logic for determining read_data_temp based on read address
  // This block continuously selects data from the appropriate memory block.
  always @* begin
    case (ra_mem_idx)
      4'd0: read_data_temp = KernMem_0[ra_word_idx];
      4'd1: read_data_temp = KernMem_1[ra_word_idx];
      4'd2: read_data_temp = KernMem_2[ra_word_idx];
      4'd3: read_data_temp = KernMem_3[ra_word_idx];
      4'd4: read_data_temp = KernMem_4[ra_word_idx];
      4'd5: read_data_temp = KernMem_5[ra_word_idx];
      4'd6: read_data_temp = KernMem_6[ra_word_idx];
      4'd7: read_data_temp = KernMem_7[ra_word_idx];
      4'd8: read_data_temp = KernMem_8[ra_word_idx];
      default: begin
        // For read addresses where ra_mem_idx is > 8 (i.e., addresses 576-1023),
        // assign 0 to read_data_temp. This provides a defined output and prevents X-propagation
        // for reads outside the valid memory range, matching typical hardware behavior.
        read_data_temp = 64'b0;
      end
    endcase
  end

  // Synchronous write logic for the memory blocks.
  // This block is sensitive only to the positive clock edge, as KernMem arrays
  // do not have an asynchronous reset.
  // Separating this from the rdata_out block resolves the STARC05-1.3.1.3 violation.
  always @(posedge clk) begin
    if (we) begin
      case (wa_mem_idx)
        4'd0: KernMem_0[wa_word_idx] <= wdata;
        4'd1: KernMem_1[wa_word_idx] <= wdata;
        4'd2: KernMem_2[wa_word_idx] <= wdata;
        4'd3: KernMem_3[wa_word_idx] <= wdata;
        4'd4: KernMem_4[wa_word_idx] <= wdata;
        4'd5: KernMem_5[wa_word_idx] <= wdata;
        4'd6: KernMem_6[wa_word_idx] <= wdata;
        4'd7: KernMem_7[wa_word_idx] <= wdata;
        4'd8: KernMem_8[wa_word_idx] <= wdata;
        default: begin
          // For write addresses where wa_mem_idx is > 8 (i.e., addresses 576-1023),
          // no write occurs, preserving the original implicit behavior for out-of-bounds writes.
        end
      endcase
    end
  end

  // Synchronous read output logic with asynchronous reset for rdata_out.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rdata_out <= 64'b0;      // Reset read output asynchronously
    end else begin
      // Register the read data on the positive clock edge if 're' is active.
      // If 're' is low, rdata_out retains its previous value.
      if (re) begin
        rdata_out <= read_data_temp;
      end
    end
  end

endmodule
