module tawas_rcn_master_buf
#(
    parameter MASTER_GROUP_8 = 0
)
(
    input rst,
    input clk,

    input [68:0] rcn_in,
    output [68:0] rcn_out,

    input cs,
    input [4:0] seq,
    input wr,
    input [3:0] mask,
    input [23:0] addr,
    input [31:0] wdata,

    output full,

    output rdone,
    output wdone,
    output [4:0] rsp_seq,
    output [3:0] rsp_mask,
    output [23:0] rsp_addr,
    output [31:0] rsp_data
);
    // Stub module: Dummy assignments to satisfy linting tools without defining actual logic.
    // The actual implementation of tawas_rcn_master_buf is external to this file.
    assign rcn_out = 69'd0;
    assign full = 1'b0;
    assign rdone = 1'b0;
    assign wdone = 1'b0;
    assign rsp_seq = 5'd0;
    assign rsp_mask = 4'd0;
    assign rsp_addr = 24'd0;
    assign rsp_data = 32'd0;

endmodule
