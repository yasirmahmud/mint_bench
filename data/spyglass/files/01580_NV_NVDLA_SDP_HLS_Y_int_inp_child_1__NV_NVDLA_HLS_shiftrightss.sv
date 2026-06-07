// NV_NVDLA_HLS_shiftrightss: Signed Arithmetic Right Shift
module NV_NVDLA_HLS_shiftrightss #(
    parameter IN_WIDTH    = 1,
    parameter OUT_WIDTH   = 1,
    parameter SHIFT_WIDTH = 1
) (
    input  [IN_WIDTH-1:0]  data_in,
    input  [SHIFT_WIDTH-1:0] shift_num,
    output [OUT_WIDTH-1:0] data_out
);

  assign data_out = $signed(data_in) >>> shift_num;

endmodule
