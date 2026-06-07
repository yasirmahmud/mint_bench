// Dummy module definition for NV_NVDLA_SDP_HLS_prelu
module NV_NVDLA_SDP_HLS_prelu #(
    parameter IN_WIDTH  = 1,
    parameter OUT_WIDTH = 1,
    parameter OP_WIDTH  = 1
) (
    input                   cfg_prelu_en,
    input  [IN_WIDTH-1:0]   data_in,
    input  [OP_WIDTH-1:0]   op_in,
    output [OUT_WIDTH-1:0]  data_out
);
    // Drive output with zeros for linting purposes
    assign data_out = {{OUT_WIDTH}{1'b0}};

    // Fix W240: Make inputs read without changing the functional behavior of driving zeros
    wire _dummy_cfg_prelu_en = cfg_prelu_en;
    wire [IN_WIDTH-1:0] _dummy_data_in = data_in;
    wire [OP_WIDTH-1:0] _dummy_op_in = op_in;
endmodule
