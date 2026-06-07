// Definition for NV_NVDLA_HLS_shiftrightsu
module NV_NVDLA_HLS_shiftrightsu #(
    parameter IN_WIDTH    = 49,
    parameter OUT_WIDTH   = 32,
    parameter SHIFT_WIDTH = 6
) (
    input  [IN_WIDTH-1:0]    data_in,
    input  [SHIFT_WIDTH-1:0] shift_num,
    output [OUT_WIDTH-1:0]   data_out
);

wire [IN_WIDTH-1:0] shifted_data_full;

// Perform arithmetic right shift for signed interpretation of data_in
// Then truncate to OUT_WIDTH.
// The intermediate 'shifted_data_full' is created to ensure the shift
// happens on the full IN_WIDTH before truncation.
assign shifted_data_full = $signed(data_in) >>> shift_num;
assign data_out = shifted_data_full[OUT_WIDTH-1:0];

endmodule
