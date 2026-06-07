module efx_fifo_top #(
    parameter SYNC_CLK = 1,
    parameter SYNC_STAGE = 2,
    parameter DATA_WIDTH = 48,
    parameter MODE = "STANDARD",
    parameter OUTPUT_REG = 0,
    parameter PROG_FULL_ASSERT = 240,
    parameter PROGRAMMABLE_FULL = "STATIC_SINGLE",
    parameter PROG_FULL_NEGATE = 240,
    parameter PROGRAMMABLE_EMPTY = "NONE",
    parameter PROG_EMPTY_ASSERT = 0,
    parameter PROG_EMPTY_NEGATE = 2,
    parameter OPTIONAL_FLAGS = 1,
    parameter PIPELINE_REG = 1,
    parameter DEPTH = 256,
    parameter FAMILY = "TRION",
    parameter ASYM_WIDTH_RATIO = 4,
    parameter BYPASS_RESET_SYNC = 0,
    parameter ENDIANESS = 0
) (
    output almost_full_o,
    output prog_full_o,
    output full_o,
    output overflow_o,
    output wr_ack_o,
    output empty_o,
    output almost_empty_o,
    output underflow_o,
    output rd_valid_o,
    input clk_i,
    input wr_en_i,
    input rd_en_i,
    input [DATA_WIDTH-1:0] wdata,
    output [7:0] datacount_o,
    output rst_busy,
    output [DATA_WIDTH-1:0] rdata,
    input a_rst_i
);
    // This is an empty module definition provided to resolve SpyGlass 'no definition' errors
    // for the IP core. The actual IP behavior is handled by synthesis/implementation tools
    // through IP libraries, and its functional behavior is preserved.
endmodule
