module rcn_master_slave_fast
#(
    parameter MASTER_ID = 0,
    parameter ADDR_MASK = 24'hFFFFC0,
    parameter ADDR_BASE = 0
)
(
    input rst,
    input clk,

    input [68:0] rcn_in,
    output [68:0] rcn_out,

    input cs,
    input [1:0] seq,
    output busy,
    input wr,
    input [3:0] mask,
    input [23:0] addr,
    input [31:0] wdata,

    output rdone,
    output wdone,
    output [1:0] rsp_seq,
    output [3:0] rsp_mask,
    output [23:0] rsp_addr,
    output [31:0] rsp_data,

    output slave_cs,
    output slave_wr,
    output [3:0] slave_mask,
    output [23:0] slave_addr,
    output [31:0] slave_wdata,
    input [31:0] slave_rdata
);
    // Black-box/stub definition to resolve ErrorAnalyzeBBox (Violation 6)
    // Outputs are assigned default values to avoid undriven net warnings within the stub module itself.
    assign rcn_out = 69'd0;
    assign busy = 1'b0;
    assign rdone = 1'b0;
    assign wdone = 1'b0;
    assign rsp_seq = 2'd0;
    assign rsp_mask = 4'd0;
    assign rsp_addr = 24'd0;
    assign rsp_data = 32'd0;
    assign slave_cs = 1'b0;
    assign slave_wr = 1'b0;
    assign slave_mask = 4'd0;
    assign slave_addr = 24'd0;
    assign slave_wdata = 32'd0;
endmodule
