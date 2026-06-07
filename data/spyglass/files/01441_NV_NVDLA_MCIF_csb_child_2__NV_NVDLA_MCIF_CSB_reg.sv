// Dummy module for NV_NVDLA_MCIF_CSB_reg to resolve black-box error
module NV_NVDLA_MCIF_CSB_reg (
    reg_rd_data,
    reg_offset,
    reg_wr_data,
    reg_wr_en,
    nvdla_core_clk,
    nvdla_core_rstn,
    rd_os_cnt,
    wr_os_cnt,
    rd_weight_bdma,
    rd_weight_cdp,
    rd_weight_pdp,
    rd_weight_sdp,
    rd_weight_cdma_dat,
    rd_weight_sdp_b,
    rd_weight_sdp_e,
    rd_weight_sdp_n,
    rd_weight_cdma_wt,
    rd_weight_rbk,
    rd_weight_rsv_0,
    rd_weight_rsv_1,
    wr_weight_bdma,
    wr_weight_cdp,
    wr_weight_pdp,
    wr_weight_sdp,
    wr_weight_rbk,
    wr_weight_rsv_0,
    wr_weight_rsv_1,
    wr_weight_rsv_2,
    idle
);

    output [31:0] reg_rd_data;
    input  [11:0] reg_offset;
    input  [31:0] reg_wr_data;
    input         reg_wr_en;
    input         nvdla_core_clk;
    input         nvdla_core_rstn;
    output [7:0]  rd_os_cnt;
    output [7:0]  wr_os_cnt;
    output [7:0]  rd_weight_bdma;
    output [7:0]  rd_weight_cdp;
    output [7:0]  rd_weight_pdp;
    output [7:0]  rd_weight_sdp;
    output [7:0]  rd_weight_cdma_dat;
    output [7:0]  rd_weight_sdp_b;
    output [7:0]  rd_weight_sdp_e;
    output [7:0]  rd_weight_sdp_n;
    output [7:0]  rd_weight_cdma_wt;
    output [7:0]  rd_weight_rbk;
    output [7:0]  rd_weight_rsv_0;
    output [7:0]  rd_weight_rsv_1;
    output [7:0]  wr_weight_bdma;
    output [7:0]  wr_weight_cdp;
    output [7:0]  wr_weight_pdp;
    output [7:0]  wr_weight_sdp;
    output [7:0]  wr_weight_rbk;
    output [7:0]  wr_weight_rsv_0;
    output [7:0]  wr_weight_rsv_1;
    output [7:0]  wr_weight_rsv_2;
    input         idle;

    // Tie outputs to a default value (e.g., 0) for a blackbox.
    // This is purely for linting and won't affect functional behavior of the parent module in a real scenario
    // as the sub-module would be provided.
    assign reg_rd_data        = 32'b0;
    assign rd_os_cnt          = 8'b0;
    assign wr_os_cnt          = 8'b0;
    assign rd_weight_bdma     = 8'b0;
    assign rd_weight_cdp      = 8'b0;
    assign rd_weight_pdp      = 8'b0;
    assign rd_weight_sdp      = 8'b0;
    assign rd_weight_cdma_dat = 8'b0;
    assign rd_weight_sdp_b    = 8'b0;
    assign rd_weight_sdp_e    = 8'b0;
    assign rd_weight_sdp_n    = 8'b0;
    assign rd_weight_cdma_wt  = 8'b0;
    assign rd_weight_rbk      = 8'b0;
    assign rd_weight_rsv_0    = 8'b0;
    assign rd_weight_rsv_1    = 8'b0;
    assign wr_weight_bdma     = 8'b0;
    assign wr_weight_cdp      = 8'b0;
    assign wr_weight_pdp      = 8'b0;
    assign wr_weight_sdp      = 8'b0;
    assign wr_weight_rbk      = 8'b0;
    assign wr_weight_rsv_0    = 8'b0;
    assign wr_weight_rsv_1    = 8'b0;
    assign wr_weight_rsv_2    = 8'b0;

endmodule
