module NV_NVDLA_MCIF_READ_IG_ARB_pipe_out (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,arb_out_pd
  ,arb_out_vld
  ,arb_out_rdy
  ,arb2spt_req_pd
  ,arb2spt_req_valid
  ,arb2spt_req_ready
);

input         nvdla_core_clk;
input         nvdla_core_rstn;
output  [NVDLA_DMA_RD_IG_PW-1:0] arb2spt_req_pd;
output         arb2spt_req_valid;
input          arb2spt_req_ready;
input [NVDLA_DMA_RD_IG_PW-1:0] arb_out_pd;
input          arb_out_vld;
output         arb_out_rdy;


//: my $mem = NVDLA_DMA_RD_IG_PW;
//: &eperl::pipe(" -wid $mem -is -di arb_out_pd -vi arb_out_vld -ro arb_out_rdy -do arb2spt_req_pd -vo arb2spt_req_valid -ri arb2spt_req_ready ");


endmodule
