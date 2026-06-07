module NV_NVDLA_MCIF_READ_IG_arb (
   arb2spt_req_ready         //|< i
  ,bpt2arb_req0_pd           //|< i
  ,bpt2arb_req0_valid        //|< i
  ,bpt2arb_req1_pd           //|< i
  ,bpt2arb_req1_valid        //|< i
  ,bpt2arb_req2_pd           //|< i
  ,bpt2arb_req2_valid        //|< i
  ,bpt2arb_req3_pd           //|< i
  ,bpt2arb_req3_valid        //|< i
  ,bpt2arb_req4_pd           //|< i
  ,bpt2arb_req4_valid        //|< i
  ,bpt2arb_req5_pd           //|< i
  ,bpt2arb_req5_valid        //|< i
  ,bpt2arb_req6_pd           //|< i
  ,bpt2arb_req6_valid        //|< i
  ,bpt2arb_req7_pd           //|< i
  ,bpt2arb_req7_valid        //|< i
  ,bpt2arb_req8_pd           //|< i
  ,bpt2arb_req8_valid        //|< i
  ,bpt2arb_req9_pd           //|< i
  ,bpt2arb_req9_valid        //|< i
  ,nvdla_core_clk            //|< i
  ,nvdla_core_rstn           //|< i
  ,reg2dp_rd_weight_bdma     //|< i
  ,reg2dp_rd_weight_cdma_dat //|< i
  ,reg2dp_rd_weight_cdma_wt  //|< i
  ,reg2dp_rd_weight_cdp      //|< i
  ,reg2dp_rd_weight_pdp      //|< i
  ,reg2dp_rd_weight_rbk      //|< i
  ,reg2dp_rd_weight_sdp      //|< i
  ,reg2dp_rd_weight_sdp_b    //|< i
  ,reg2dp_rd_weight_sdp_e    //|< i
  ,reg2dp_rd_weight_sdp_n    //|< i
  ,arb2spt_req_pd            //|> o
  ,arb2spt_req_valid         //|> o
  ,bpt2arb_req0_ready        //|> o
  ,bpt2arb_req1_ready        //|> o
  ,bpt2arb_req2_ready        //|> o
  ,bpt2arb_req3_ready        //|> o
  ,bpt2arb_req4_ready        //|> o
  ,bpt2arb_req5_ready        //|> o
  ,bpt2arb_req6_ready        //|> o
  ,bpt2arb_req7_ready        //|> o
  ,bpt2arb_req8_ready        //|> o
  ,bpt2arb_req9_ready        //|> o
  );
//
// NV_NVDLA_MCIF_READ_IG_arb_ports.v
//
input  nvdla_core_clk;
input  nvdla_core_rstn;

input         bpt2arb_req0_valid;  /* data valid */
output        bpt2arb_req0_ready;  /* data return handshake */
input  [74:0] bpt2arb_req0_pd;

input         bpt2arb_req1_valid;  /* data valid */
output        bpt2arb_req1_ready;  /* data return handshake */
input  [74:0] bpt2arb_req1_pd;

input         bpt2arb_req2_valid;  /* data valid */
output        bpt2arb_req2_ready;  /* data return handshake */
input  [74:0] bpt2arb_req2_pd;

input         bpt2arb_req3_valid;  /* data valid */
output        bpt2arb_req3_ready;  /* data return handshake */
input  [74:0] bpt2arb_req3_pd;

input         bpt2arb_req4_valid;  /* data valid */
output        bpt2arb_req4_ready;  /* data return handshake */
input  [74:0] bpt2arb_req4_pd;

input         bpt2arb_req5_valid;  /* data valid */
output        bpt2arb_req5_ready;  /* data return handshake */
input  [74:0] bpt2arb_req5_pd;

input         bpt2arb_req6_valid;  /* data valid */
output        bpt2arb_req6_ready;  /* data return handshake */
input  [74:0] bpt2arb_req6_pd;

input         bpt2arb_req7_valid;  /* data valid */
output        bpt2arb_req7_ready;  /* data return handshake */
input  [74:0] bpt2arb_req7_pd;

input         bpt2arb_req8_valid;  /* data valid */
output        bpt2arb_req8_ready;  /* data return handshake */
input  [74:0] bpt2arb_req8_pd;

input         bpt2arb_req9_valid;  /* data valid */
output        bpt2arb_req9_ready;  /* data return handshake */
input  [74:0] bpt2arb_req9_pd;

output        arb2spt_req_valid;  /* data valid */
input         arb2spt_req_ready;  /* data return handshake */
output [74:0] arb2spt_req_pd;

input  [7:0] reg2dp_rd_weight_bdma;
input  [7:0] reg2dp_rd_weight_cdma_dat;
input  [7:0] reg2dp_rd_weight_cdma_wt;
input  [7:0] reg2dp_rd_weight_cdp;
input  [7:0] reg2dp_rd_weight_pdp;
input  [7:0] reg2dp_rd_weight_rbk;
input  [7:0] reg2dp_rd_weight_sdp;
input  [7:0] reg2dp_rd_weight_sdp_b;
input  [7:0] reg2dp_rd_weight_sdp_e;
input  [7:0] reg2dp_rd_weight_sdp_n;
reg   [74:0] arb_pd;
wire   [9:0] arb_gnt;
wire  [74:0] arb_src0_pd;
wire         arb_src0_rdy;
wire         arb_src0_vld;
wire  [74:0] arb_src1_pd;
wire         arb_src1_rdy;
wire         arb_src1_vld;
wire  [74:0] arb_src2_pd;
wire         arb_src2_rdy;
wire         arb_src2_vld;
wire  [74:0] arb_src3_pd;
wire         arb_src3_rdy;
wire         arb_src3_vld;
wire  [74:0] arb_src4_pd;
wire         arb_src4_rdy;
wire         arb_src4_vld;
wire  [74:0] arb_src5_pd;
wire         arb_src5_rdy;
wire         arb_src5_vld;
wire  [74:0] arb_src6_pd;
wire         arb_src6_rdy;
wire         arb_src6_vld;
wire  [74:0] arb_src7_pd;
wire         arb_src7_rdy;
wire         arb_src7_vld;
wire  [74:0] arb_src8_pd;
wire         arb_src8_rdy;
wire         arb_src8_vld;
wire  [74:0] arb_src9_pd;
wire         arb_src9_rdy;
wire         arb_src9_vld;
wire         gnt_busy;
wire         src0_gnt;
wire         src0_req;
wire         src1_gnt;
wire         src1_req;
wire         src2_gnt;
wire         src2_req;
wire         src3_gnt;
wire         src3_req;
wire         src4_gnt;
wire         src4_req;
wire         src5_gnt;
wire         src5_req;
wire         src6_gnt;
wire         src6_req;
wire         src7_gnt;
wire         src7_req;
wire         src8_gnt;
wire         src8_req;
wire         src9_gnt;
wire         src9_req;
wire   [7:0] wt0;
wire   [7:0] wt1;
wire   [7:0] wt2;
wire   [7:0] wt3;
wire   [7:0] wt4;
wire   [7:0] wt5;
wire   [7:0] wt6;
wire   [7:0] wt7;
wire   [7:0] wt8;
wire   [7:0] wt9;
// synoff nets

// monitor nets

// debug nets

// tie high nets

// tie low nets

// no connect nets

// not all bits used nets

// todo nets

    

NV_NVDLA_MCIF_READ_IG_ARB_pipe_p1 pipe_p1 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src0_rdy       (arb_src0_rdy)          //|< w
  ,.bpt2arb_req0_pd    (bpt2arb_req0_pd[74:0]) //|< i
  ,.bpt2arb_req0_valid (bpt2arb_req0_valid)    //|< i
  ,.arb_src0_pd        (arb_src0_pd[74:0])     //|> w
  ,.arb_src0_vld       (arb_src0_vld)          //|> w
  ,.bpt2arb_req0_ready (bpt2arb_req0_ready)    //|> o
  );
assign src0_req   = arb_src0_vld;
assign arb_src0_rdy = src0_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p2 pipe_p2 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src1_rdy       (arb_src1_rdy)          //|< w
  ,.bpt2arb_req1_pd    (bpt2arb_req1_pd[74:0]) //|< i
  ,.bpt2arb_req1_valid (bpt2arb_req1_valid)    //|< i
  ,.arb_src1_pd        (arb_src1_pd[74:0])     //|> w
  ,.arb_src1_vld       (arb_src1_vld)          //|> w
  ,.bpt2arb_req1_ready (bpt2arb_req1_ready)    //|> o
  );
assign src1_req   = arb_src1_vld;
assign arb_src1_rdy = src1_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p3 pipe_p3 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src2_rdy       (arb_src2_rdy)          //|< w
  ,.bpt2arb_req2_pd    (bpt2arb_req2_pd[74:0]) //|< i
  ,.bpt2arb_req2_valid (bpt2arb_req2_valid)    //|< i
  ,.arb_src2_pd        (arb_src2_pd[74:0])     //|> w
  ,.arb_src2_vld       (arb_src2_vld)          //|> w
  ,.bpt2arb_req2_ready (bpt2arb_req2_ready)    //|> o
  );
assign src2_req   = arb_src2_vld;
assign arb_src2_rdy = src2_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p4 pipe_p4 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src3_rdy       (arb_src3_rdy)          //|< w
  ,.bpt2arb_req3_pd    (bpt2arb_req3_pd[74:0]) //|< i
  ,.bpt2arb_req3_valid (bpt2arb_req3_valid)    //|< i
  ,.arb_src3_pd        (arb_src3_pd[74:0])     //|> w
  ,.arb_src3_vld       (arb_src3_vld)          //|> w
  ,.bpt2arb_req3_ready (bpt2arb_req3_ready)    //|> o
  );
assign src3_req   = arb_src3_vld;
assign arb_src3_rdy = src3_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p5 pipe_p5 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src4_rdy       (arb_src4_rdy)          //|< w
  ,.bpt2arb_req4_pd    (bpt2arb_req4_pd[74:0]) //|< i
  ,.bpt2arb_req4_valid (bpt2arb_req4_valid)    //|< i
  ,.arb_src4_pd        (arb_src4_pd[74:0])     //|> w
  ,.arb_src4_vld       (arb_src4_vld)          //|> w
  ,.bpt2arb_req4_ready (bpt2arb_req4_ready)    //|> o
  );
assign src4_req   = arb_src4_vld;
assign arb_src4_rdy = src4_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p6 pipe_p6 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src5_rdy       (arb_src5_rdy)          //|< w
  ,.bpt2arb_req5_pd    (bpt2arb_req5_pd[74:0]) //|< i
  ,.bpt2arb_req5_valid (bpt2arb_req5_valid)    //|< i
  ,.arb_src5_pd        (arb_src5_pd[74:0])     //|> w
  ,.arb_src5_vld       (arb_src5_vld)          //|> w
  ,.bpt2arb_req5_ready (bpt2arb_req5_ready)    //|> o
  );
assign src5_req   = arb_src5_vld;
assign arb_src5_rdy = src5_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p7 pipe_p7 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src6_rdy       (arb_src6_rdy)          //|< w
  ,.bpt2arb_req6_pd    (bpt2arb_req6_pd[74:0]) //|< i
  ,.bpt2arb_req6_valid (bpt2arb_req6_valid)    //|< i
  ,.arb_src6_pd        (arb_src6_pd[74:0])     //|> w
  ,.arb_src6_vld       (arb_src6_vld)          //|> w
  ,.bpt2arb_req6_ready (bpt2arb_req6_ready)    //|> o
  );
assign src6_req   = arb_src6_vld;
assign arb_src6_rdy = src6_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p8 pipe_p8 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src7_rdy       (arb_src7_rdy)          //|< w
  ,.bpt2arb_req7_pd    (bpt2arb_req7_pd[74:0]) //|< i
  ,.bpt2arb_req7_valid (bpt2arb_req7_valid)    //|< i
  ,.arb_src7_pd        (arb_src7_pd[74:0])     //|> w
  ,.arb_src7_vld       (arb_src7_vld)          //|> w
  ,.bpt2arb_req7_ready (bpt2arb_req7_ready)    //|> o
  );
assign src7_req   = arb_src7_vld;
assign arb_src7_rdy = src7_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p9 pipe_p9 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src8_rdy       (arb_src8_rdy)          //|< w
  ,.bpt2arb_req8_pd    (bpt2arb_req8_pd[74:0]) //|< i
  ,.bpt2arb_req8_valid (bpt2arb_req8_valid)    //|< i
  ,.arb_src8_pd        (arb_src8_pd[74:0])     //|> w
  ,.arb_src8_vld       (arb_src8_vld)          //|> w
  ,.bpt2arb_req8_ready (bpt2arb_req8_ready)    //|> o
  );
assign src8_req   = arb_src8_vld;
assign arb_src8_rdy = src8_gnt;
NV_NVDLA_MCIF_READ_IG_ARB_pipe_p10 pipe_p10 (
   .nvdla_core_clk     (nvdla_core_clk)        //|< i
  ,.nvdla_core_rstn    (nvdla_core_rstn)       //|< i
  ,.arb_src9_rdy       (arb_src9_rdy)          //|< w
  ,.bpt2arb_req9_pd    (bpt2arb_req9_pd[74:0]) //|< i
  ,.bpt2arb_req9_valid (bpt2arb_req9_valid)    //|< i
  ,.arb_src9_pd        (arb_src9_pd[74:0])     //|> w
  ,.arb_src9_vld       (arb_src9_vld)          //|> w
  ,.bpt2arb_req9_ready (bpt2arb_req9_ready)    //|> o
  );
assign src9_req   = arb_src9_vld;
assign arb_src9_rdy = src9_gnt;

assign wt0 = reg2dp_rd_weight_bdma;
assign wt1 = reg2dp_rd_weight_sdp;
assign wt2 = reg2dp_rd_weight_pdp;
assign wt3 = reg2dp_rd_weight_cdp;
assign wt4 = reg2dp_rd_weight_rbk;
assign wt5 = reg2dp_rd_weight_sdp_b;
assign wt6 = reg2dp_rd_weight_sdp_n;
assign wt7 = reg2dp_rd_weight_sdp_e;
assign wt8 = reg2dp_rd_weight_cdma_dat;
assign wt9 = reg2dp_rd_weight_cdma_wt;

read_ig_arb u_read_ig_arb (
   .req0               (src0_req)              //|< w
  ,.req1               (src1_req)              //|< w
  ,.req2               (src2_req)              //|< w
  ,.req3               (src3_req)              //|< w
  ,.req4               (src4_req)              //|< w
  ,.req5               (src5_req)              //|< w
  ,.req6               (src6_req)              //|< w
  ,.req7               (src7_req)              //|< w
  ,.req8               (src8_req)              //|< w
  ,.req9               (src9_req)              //|< w
  ,.wt0                (wt0[7:0])              //|< w
  ,.wt1                (wt1[7:0])              //|< w
  ,.wt2                (wt2[7:0])              //|< w
  ,.wt3                (wt3[7:0])              //|< w
  ,.wt4                (wt4[7:0])              //|< w
  ,.wt5                (wt5[7:0])              //|< w
  ,.wt6                (wt6[7:0])              //|< w
  ,.wt7                (wt7[7:0])              //|< w
  ,.wt8                (wt8[7:0])              //|< w
  ,.wt9                (wt9[7:0])              //|< w
  ,.gnt_busy           (gnt_busy)              //|< w
  ,.clk                (nvdla_core_clk)        //|< i
  ,.reset_             (nvdla_core_rstn)       //|< i
  ,.gnt0               (src0_gnt)              //|> w
  ,.gnt1               (src1_gnt)              //|> w
  ,.gnt2               (src2_gnt)              //|> w
  ,.gnt3               (src3_gnt)              //|> w
  ,.gnt4               (src4_gnt)              //|> w
  ,.gnt5               (src5_gnt)              //|> w
  ,.gnt6               (src6_gnt)              //|> w
  ,.gnt7               (src7_gnt)              //|> w
  ,.gnt8               (src8_gnt)              //|> w
  ,.gnt9               (src9_gnt)              //|> w
  );

// MUX OUT
always @(
  src0_gnt
  or arb_src0_pd
  or src1_gnt
  or arb_src1_pd
  or src2_gnt
  or arb_src2_pd
  or src3_gnt
  or arb_src3_pd
  or src4_gnt
  or arb_src4_pd
  or src5_gnt
  or arb_src5_pd
  or src6_gnt
  or arb_src6_pd
  or src7_gnt
  or arb_src7_pd
  or src8_gnt
  or arb_src8_pd
  or src9_gnt
  or arb_src9_pd
  ) begin
//spyglass disable_block W171 W226
    case (1'b1 )
       src0_gnt: arb_pd = arb_src0_pd;
       src1_gnt: arb_pd = arb_src1_pd;
       src2_gnt: arb_pd = arb_src2_pd;
       src3_gnt: arb_pd = arb_src3_pd;
       src4_gnt: arb_pd = arb_src4_pd;
       src5_gnt: arb_pd = arb_src5_pd;
       src6_gnt: arb_pd = arb_src6_pd;
       src7_gnt: arb_pd = arb_src7_pd;
       src8_gnt: arb_pd = arb_src8_pd;
       src9_gnt: arb_pd = arb_src9_pd;
    //VCS coverage off
    default : begin 
                arb_pd[74:0] = {75{`x_or_0}};
              end  
    //VCS coverage on
    endcase
//spyglass enable_block W171 W226
end

assign arb_gnt = {src9_gnt, src8_gnt, src7_gnt, src6_gnt, src5_gnt, src4_gnt, src3_gnt, src2_gnt, src1_gnt, src0_gnt};
assign arb2spt_req_valid = |arb_gnt;
assign gnt_busy = !arb2spt_req_ready;

assign arb2spt_req_pd = arb_pd;

//==========================================
// OBS
//assign obs_bus_mcif_read_ig_arb_gnt_busy = gnt_busy;

endmodule
