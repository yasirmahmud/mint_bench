// NV_NVDLA_HLS_shiftrightsu definition
module NV_NVDLA_HLS_shiftrightsu #(
    parameter IN_WIDTH    = 49,
    parameter OUT_WIDTH   = 32,
    parameter SHIFT_WIDTH = 6
) (
    input  [IN_WIDTH-1:0]    data_in,
    input  [SHIFT_WIDTH-1:0] shift_num,
    output [OUT_WIDTH-1:0]   data_out
);

    wire [IN_WIDTH-1:0] signed_data_in = $signed(data_in);
    wire [IN_WIDTH-1:0] shifted_data = signed_data_in >>> shift_num; // Arithmetic right shift

    assign data_out = shifted_data[OUT_WIDTH-1:0];

endmodule
