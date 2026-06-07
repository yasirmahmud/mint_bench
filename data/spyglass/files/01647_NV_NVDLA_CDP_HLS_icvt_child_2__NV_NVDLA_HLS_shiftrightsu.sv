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
  // To resolve STX_VE_481, explicitly declare data_in as signed for the shift operation.
  // This ensures the expression before bit-selection is unambiguously a signed vector.
  wire signed [IN_WIDTH-1:0] s_data_in;
  assign s_data_in = data_in;

  // Perform signed right shift and truncate to OUT_WIDTH
  assign data_out = (s_data_in >>> shift_num)[OUT_WIDTH-1:0];
endmodule
