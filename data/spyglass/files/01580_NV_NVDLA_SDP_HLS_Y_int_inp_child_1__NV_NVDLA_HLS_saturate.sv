// NV_NVDLA_HLS_saturate: Signed Saturation
module NV_NVDLA_HLS_saturate #(
    parameter IN_WIDTH  = 1,
    parameter OUT_WIDTH = 1
) (
    input  [IN_WIDTH-1:0]  data_in,
    output [OUT_WIDTH-1:0] data_out
);
    localparam [OUT_WIDTH-1:0] MAX_OUT_VAL = {1'b0, {(OUT_WIDTH-1){1'b1}}};
    localparam [OUT_WIDTH-1:0] MIN_OUT_VAL = {1'b1, {(OUT_WIDTH-1){1'b0}}};

    assign data_out = ($signed(data_in) > $signed(MAX_OUT_VAL)) ? MAX_OUT_VAL :
                      ($signed(data_in) < $signed(MIN_OUT_VAL)) ? MIN_OUT_VAL :
                      data_in[OUT_WIDTH-1:0];

endmodule
