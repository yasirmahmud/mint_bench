module NV_NVDLA_MCIF_READ_IG_ARB_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,bpt2arb_req_pd
  ,bpt2arb_req_valid
  ,bpt2arb_req_ready
  ,arb_src_pd
  ,arb_src_vld
  ,arb_src_rdy
);

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [NVDLA_DMA_RD_IG_PW-1:0] bpt2arb_req_pd;
input         bpt2arb_req_valid;
output        bpt2arb_req_ready;
output [NVDLA_DMA_RD_IG_PW-1:0] arb_src_pd;
output        arb_src_vld;
input         arb_src_rdy;


//: my $mem = NVDLA_DMA_RD_IG_PW;
//: &eperl::pipe(" -wid $mem -is -do arb_src_pd -vo arb_src_vld -ri arb_src_rdy -di bpt2arb_req_pd -vi bpt2arb_req_valid -ro bpt2arb_req_ready ");


endmodule
