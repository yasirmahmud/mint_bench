module efx_fifo_top #(
    parameter SYNC_CLK = 0,
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
    input wr_clk_i,
    input rd_clk_i,
    input wr_en_i,
    input rd_en_i,
    input [DATA_WIDTH-1:0] wdata,
    output [($clog2(DEPTH))-1:0] wr_datacount_o,
    output rst_busy,
    output [DATA_WIDTH-1:0] rdata,
    output [($clog2(DEPTH))-1:0] rd_datacount_o,
    input a_rst_i
);
    // This is a stub module to resolve the SpyGlass 'ErrorAnalyzeBBox' violation.
    // In a real design, this would be replaced by the actual efx_fifo_top IP or module definition.
    // Outputs are assigned default values to prevent 'X' propagation during simulation if this stub is used.
    assign almost_full_o = 1'b0;
    assign prog_full_o = 1'b0;
    assign full_o = 1'b0;
    assign overflow_o = 1'b0;
    assign wr_ack_o = 1'b0;
    assign empty_o = 1'b1;
    assign almost_empty_o = 1'b1;
    assign underflow_o = 1'b0;
    assign rd_valid_o = 1'b0;
    assign wr_datacount_o = '0;
    assign rst_busy = 1'b0;
    assign rdata = '0;
    assign rd_datacount_o = '0;

endmodule
