// NV_NVDLA_HLS_shiftrightsu definition
module NV_NVDLA_HLS_shiftrightsu #(
  parameter IN_WIDTH    = 1,
  parameter OUT_WIDTH   = 1,
  parameter SHIFT_WIDTH = 1
) (
  input  [IN_WIDTH-1:0]    data_in,
  input  [SHIFT_WIDTH-1:0] shift_num,
  output [OUT_WIDTH-1:0]   data_out
);
  // Perform signed right shift and truncate to OUT_WIDTH
  assign data_out = ($signed(data_in) >>> shift_num)[OUT_WIDTH-1:0];
endmodule
