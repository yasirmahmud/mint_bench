module NV_NVDLA_HLS_shiftleftsu #(
   parameter IN_WIDTH    = 1
  ,parameter OUT_WIDTH   = 1
  ,parameter SHIFT_WIDTH = 1
) (
   input  [IN_WIDTH-1:0]    data_in
  ,input  [SHIFT_WIDTH-1:0] shift_num
  ,output [OUT_WIDTH-1:0]   data_out
);
   // Simple logical shift with zero-extension/truncation for linting
   assign data_out = data_in << shift_num;
endmodule
