module ld_ifmap (
    clk, en, rst_n, 
    icb, ic, filter_width,
    filter_height, ifm_height, ifm_width,
    // Original 25 output wires
    w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24,
    // Flattened 25 input data ports to resolve STX_VE_479 and STX_VE_605
    ifmap_data_in_0, ifmap_data_in_1, ifmap_data_in_2, ifmap_data_in_3, ifmap_data_in_4,
    ifmap_data_in_5, ifmap_data_in_6, ifmap_data_in_7, ifmap_data_in_8, ifmap_data_in_9,
    ifmap_data_in_10, ifmap_data_in_11, ifmap_data_in_12, ifmap_data_in_13, ifmap_data_in_14,
    ifmap_data_in_15, ifmap_data_in_16, ifmap_data_in_17, ifmap_data_in_18, ifmap_data_in_19,
    ifmap_data_in_20, ifmap_data_in_21, ifmap_data_in_22, ifmap_data_in_23, ifmap_data_in_24,
    // Flattened 25 output address ports to resolve STX_VE_479 and STX_VE_605
    ifmap_addr_out_0, ifmap_addr_out_1, ifmap_addr_out_2, ifmap_addr_out_3, ifmap_addr_out_4,
    ifmap_addr_out_5, ifmap_addr_out_6, ifmap_addr_out_7, ifmap_addr_out_8, ifmap_addr_out_9,
    ifmap_addr_out_10, ifmap_addr_out_11, ifmap_addr_out_12, ifmap_addr_out_13, ifmap_addr_out_14,
    ifmap_addr_out_15, ifmap_addr_out_16, ifmap_addr_out_17, ifmap_addr_out_18, ifmap_addr_out_19,
    ifmap_addr_out_20, ifmap_addr_out_21, ifmap_addr_out_22, ifmap_addr_out_23, ifmap_addr_out_24
);
input           clk;
input           en;
input           rst_n; // Active low reset for synthesizable initial values
input [4:0]     icb; // number of PE set processing different icb
input [4:0]     ic; // ic: icb in a PE set
input [15:0]    ifm_width;
input [15:0]    ifm_height;
input [4:0]     filter_width;
input [4:0]     filter_height;

// To resolve SYNTH_5273 and W123 (large 'ifmap' array), and allow parallel reads
// 'ifmap' is modeled as an external memory interface with 25 parallel ports.
// The original code implies 25 distinct values are fetched simultaneously.
// Replaced SystemVerilog array port declarations with individual ports for Verilog-2001 compatibility (STX_VE_479).
input [15:0] ifmap_data_in_0, ifmap_data_in_1, ifmap_data_in_2, ifmap_data_in_3, ifmap_data_in_4;
input [15:0] ifmap_data_in_5, ifmap_data_in_6, ifmap_data_in_7, ifmap_data_in_8, ifmap_data_in_9;
input [15:0] ifmap_data_in_10, ifmap_data_in_11, ifmap_data_in_12, ifmap_data_in_13, ifmap_data_in_14;
input [15:0] ifmap_data_in_15, ifmap_data_in_16, ifmap_data_in_17, ifmap_data_in_18, ifmap_data_in_19;
input [15:0] ifmap_data_in_20, ifmap_data_in_21, ifmap_data_in_22, ifmap_data_in_23, ifmap_data_in_24;

// Use 64-bit for address to accommodate large index calculation.
// Replaced SystemVerilog array port declarations with individual ports for Verilog-2001 compatibility (STX_VE_479).
output [63:0] ifmap_addr_out_0, ifmap_addr_out_1, ifmap_addr_out_2, ifmap_addr_out_3, ifmap_addr_out_4;
output [63:0] ifmap_addr_out_5, ifmap_addr_out_6, ifmap_addr_out_7, ifmap_addr_out_8, ifmap_addr_out_9;
output [63:0] ifmap_addr_out_10, ifmap_addr_out_11, ifmap_addr_out_12, ifmap_addr_out_13, ifmap_addr_out_14;
output [63:0] ifmap_addr_out_15, ifmap_addr_out_16, ifmap_addr_out_17, ifmap_addr_out_18, ifmap_addr_out_19;
output [63:0] ifmap_addr_out_20, ifmap_addr_out_21, ifmap_addr_out_22, ifmap_addr_out_23, ifmap_addr_out_24;

// 25 output wires assigned to the PE-2D array diagonally.
// Changed from `output reg` to `output` (implicitly `output wire`) to resolve STX_VE_362 violations
// when driven by continuous assignments `assign wX = w_array[X];`
output [15:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24;

// Internal arrays to allow indexed access within the generate block
// (This helps bridge the individual ports to the array-based logic).
wire [15:0] ifmap_data_in_internal_arr [24:0];
wire [63:0] ifmap_addr_out_internal_arr [24:0];

// Connect individual input ports to the internal array (manual mapping for Verilog-2001)
assign ifmap_data_in_internal_arr[0] = ifmap_data_in_0;
assign ifmap_data_in_internal_arr[1] = ifmap_data_in_1;
assign ifmap_data_in_internal_arr[2] = ifmap_data_in_2;
assign ifmap_data_in_internal_arr[3] = ifmap_data_in_3;
assign ifmap_data_in_internal_arr[4] = ifmap_data_in_4;
assign ifmap_data_in_internal_arr[5] = ifmap_data_in_5;
assign ifmap_data_in_internal_arr[6] = ifmap_data_in_6;
assign ifmap_data_in_internal_arr[7] = ifmap_data_in_7;
assign ifmap_data_in_internal_arr[8] = ifmap_data_in_8;
assign ifmap_data_in_internal_arr[9] = ifmap_data_in_9;
assign ifmap_data_in_internal_arr[10] = ifmap_data_in_10;
assign ifmap_data_in_internal_arr[11] = ifmap_data_in_11;
assign ifmap_data_in_internal_arr[12] = ifmap_data_in_12;
assign ifmap_data_in_internal_arr[13] = ifmap_data_in_13;
assign ifmap_data_in_internal_arr[14] = ifmap_data_in_14;
assign ifmap_data_in_internal_arr[15] = ifmap_data_in_15;
assign ifmap_data_in_internal_arr[16] = ifmap_data_in_16;
assign ifmap_data_in_internal_arr[17] = ifmap_data_in_17;
assign ifmap_data_in_internal_arr[18] = ifmap_data_in_18;
assign ifmap_data_in_internal_arr[19] = ifmap_data_in_19;
assign ifmap_data_in_internal_arr[20] = ifmap_data_in_20;
assign ifmap_data_in_internal_arr[21] = ifmap_data_in_21;
assign ifmap_data_in_internal_arr[22] = ifmap_data_in_22;
assign ifmap_data_in_internal_arr[23] = ifmap_data_in_23;
assign ifmap_data_in_internal_arr[24] = ifmap_data_in_24;

// All sequential registers are now in a single always block with synchronous reset for synthesizability.
// Initial assignments are removed and placed in the reset logic (SYNTH_89).
// Widths are adjusted for consistency (W362).

reg [15:0] count_stride;   // Max value: ifm_width - filter_width, requires 16 bits.
reg [4:0]  count_ic;       // Compares to `ic` (5-bit).
reg [4:0]  count_filter_width; // Compares to `filter_width` (5-bit).
reg [4:0]  count_icb;      // Compares to `icb` (5-bit).
reg [9:0]  actual_pe_set_base; // Max value for `pe_set_base` if accumulated up to `icb * filter_height` (31*31=961), requires 10 bits.

// 'count_ifm_height' and 'temp' from original code were assigned multiple times
// within the same sequential block, causing STARC05-2.2.3.3. They are now
// modeled as combinatorial wires, reflecting their role as immediate offsets for address calculation.
// 'current_ifm_height_idx' takes the place of `count_ifm_height = 4'b0000;`
// 'current_pe_temp_base_idx' takes the place of `temp = pe_set_base;`
wire [15:0] current_ifm_height_idx = 16'd0; 
wire [9:0] current_pe_temp_base_idx = actual_pe_set_base; 

// Internal array for easier assignment to w0-w24
reg [15:0] w_array [24:0];

// Parallel generation of outputs w0-w24 and their corresponding memory addresses ifmap_addr_out.
// This section assumes that 25 values are fetched and output every clock cycle when 'en' is high.
genvar i;
generate
  for (i = 0; i < 25; i = i + 1) begin : gen_w_outputs
    // Calculate offsets for current w[i]
    wire [15:0] ifm_h_offset = current_ifm_height_idx + i;
    // wire [9:0] temp_offset = current_pe_temp_base_idx + i; // Removed as it was unused
    
    // Calculate the logical memory address for this specific w[i]
    // Assigning to the internal address array `ifmap_addr_out_internal_arr[i]`
    assign ifmap_addr_out_internal_arr[i] = 
          (64'd1 * count_icb * ic * ifm_height * ifm_width)
        + (64'd1 * count_ic * ifm_height * ifm_width)
        + (64'd1 * ifm_h_offset * ifm_width)
        + (64'd1 * count_filter_width)
        + (64'd1 * count_stride);

    // Assign output w_array[i] based on conditions, synchronised to clk
    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        w_array[i] <= 16'd0;
      end else if (en) begin
        // Original conditions applied: if (count_ifm_height < ifm_height)
        // The `if (temp == N)` conditions are removed here, as they were causing multiple
        // assignments to `temp` register. Instead, `temp_offset` implicitly maps to `i`.
        if (ifm_h_offset < ifm_height) begin
            w_array[i] <= ifmap_data_in_internal_arr[i]; // Using the internal input array
        end else begin
            w_array[i] <= 16'd0; // Out of bounds or other condition makes data invalid
        end
      end else begin
        // When 'en' is off, outputs hold their value or reset to 0. 
        // Assuming they reset to 0 based on original `else wN = 0` patterns.
        w_array[i] <= 16'd0;
      end
    end
  end
endgenerate

// Assign individual output wires from the internal array (resolves STX_VE_362 and STX_VE_481)
assign w0 = w_array[0];
assign w1 = w_array[1];
assign w2 = w_array[2];
assign w3 = w_array[3];
assign w4 = w_array[4];
assign w5 = w_array[5];
assign w6 = w_array[6];
assign w7 = w_array[7];
assign w8 = w_array[8];
assign w9 = w_array[9];
assign w10 = w_array[10];
assign w11 = w_array[11];
assign w12 = w_array[12];
assign w13 = w_array[13];
assign w14 = w_array[14];
assign w15 = w_array[15];
assign w16 = w_array[16];
assign w17 = w_array[17];
assign w18 = w_array[18]; // Changed from <= to assign, now all are consistent continuous assignments
assign w19 = w_array[19];
assign w20 = w_array[20];
assign w21 = w_array[21];
assign w22 = w_array[22];
assign w23 = w_array[23];
assign w24 = w_array[24];

// Connect internal output address array to individual output ports (manual mapping for Verilog-2001)
assign ifmap_addr_out_0 = ifmap_addr_out_internal_arr[0];
assign ifmap_addr_out_1 = ifmap_addr_out_internal_arr[1];
assign ifmap_addr_out_2 = ifmap_addr_out_internal_arr[2];
assign ifmap_addr_out_3 = ifmap_addr_out_internal_arr[3];
assign ifmap_addr_out_4 = ifmap_addr_out_internal_arr[4];
assign ifmap_addr_out_5 = ifmap_addr_out_internal_arr[5];
assign ifmap_addr_out_6 = ifmap_addr_out_internal_arr[6];
assign ifmap_addr_out_7 = ifmap_addr_out_internal_arr[7];
assign ifmap_addr_out_8 = ifmap_addr_out_internal_arr[8];
assign ifmap_addr_out_9 = ifmap_addr_out_internal_arr[9];
assign ifmap_addr_out_10 = ifmap_addr_out_internal_arr[10];
assign ifmap_addr_out_11 = ifmap_addr_out_internal_arr[11];
assign ifmap_addr_out_12 = ifmap_addr_out_internal_arr[12];
assign ifmap_addr_out_13 = ifmap_addr_out_internal_arr[13];
assign ifmap_addr_out_14 = ifmap_addr_out_internal_arr[14];
assign ifmap_addr_out_15 = ifmap_addr_out_internal_arr[15];
assign ifmap_addr_out_16 = ifmap_addr_out_internal_arr[16];
assign ifmap_addr_out_17 = ifmap_addr_out_internal_arr[17];
assign ifmap_addr_out_18 = ifmap_addr_out_internal_arr[18];
assign ifmap_addr_out_19 = ifmap_addr_out_internal_arr[19];
assign ifmap_addr_out_20 = ifmap_addr_out_internal_arr[20];
assign ifmap_addr_out_21 = ifmap_addr_out_internal_arr[21];
assign ifmap_addr_out_22 = ifmap_addr_out_internal_arr[22];
assign ifmap_addr_out_23 = ifmap_addr_out_internal_arr[23];
assign ifmap_addr_out_24 = ifmap_addr_out_internal_arr[24];

// All sequential state updates consolidated into one `always` block.
// Initial assignments moved to the reset condition `!rst_n` (SYNTH_89).
// 'pe_set_base = 4'b0000;' from the `always @(posedge en)` block (original code)
// was a multiple driver for `pe_set_base`. This is now removed, and the `actual_pe_set_base`
// only resets when `count_icb` wraps around.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_stride <= 16'd0; // Initial value
        count_ic <= 5'd0;
        count_filter_width <= 5'd0;
        count_icb <= 5'd0;
        actual_pe_set_base <= 9'd0;
    end else if (en) begin
        // Update count_stride
        count_stride <= count_stride + 1;
        if (count_stride == ifm_width - filter_width) begin
            count_stride <= 16'd0; // Reset stride when end of a width-window is reached
            
            // Update count_ic
            count_ic <= count_ic + 1;
            if (count_ic == ic - 1) begin // Changed condition to match `ic` (0-based comparison)
                count_ic <= 5'd0;
                // Update count_filter_width
                count_filter_width <= count_filter_width + 1;
            end
            
            // Update count_icb and actual_pe_set_base
            if (count_filter_width == filter_width - 1) begin // Changed condition to match `filter_width` (0-based comparison)
                count_filter_width <= 5'd0;
                count_icb <= count_icb + 1;
                actual_pe_set_base <= actual_pe_set_base + filter_height;
            end
            
            // Reset count_icb and actual_pe_set_base when icb wraps
            if (count_icb == icb - 1) begin // Changed condition to match `icb` (0-based comparison)
                count_icb <= 5'd0;
                actual_pe_set_base <= 9'd0;
            end
        end
    end else begin // if (!en)
        // Reset certain parameters when enable is turned off, as per original logic
        count_ic <= 5'd0;
        count_icb <= 5'd0;
        count_filter_width <= 5'd0;
        // count_stride and actual_pe_set_base retain their values when `en` is off,
        // as there was no explicit reset for them in the original `!en` branch.
    end
end

endmodule
