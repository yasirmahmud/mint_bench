// Dummy module definition for NV_NVDLA_SDP_HLS_sync2data
module NV_NVDLA_SDP_HLS_sync2data #(
    parameter DATA1_WIDTH = 1,
    parameter DATA2_WIDTH = 1
) (
    input                  chn1_en,
    input                  chn2_en,
    input                  chn1_in_pvld,
    output                 chn1_in_prdy,
    input                  chn2_in_pvld,
    output                 chn2_in_prdy,
    output                 chn_out_pvld,
    input                  chn_out_prdy,
    input  [DATA1_WIDTH-1:0] data1_in,
    input  [DATA2_WIDTH-1:0] data2_in,
    output [DATA1_WIDTH-1:0] data1_out,
    output [DATA2_WIDTH-1:0] data2_out
);
    // Simple passthrough and logic for linting purposes
    assign chn1_in_prdy = chn_out_prdy;
    assign chn2_in_prdy = chn_out_prdy;
    assign chn_out_pvld = (chn1_en && chn1_in_pvld) || (chn2_en && chn2_in_pvld);
    assign data1_out = data1_in;
    assign data2_out = data2_in;
endmodule
