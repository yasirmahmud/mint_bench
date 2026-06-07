module NV_NVDLA_MCIF_WRITE_IG_BPT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma2bpt_req_pd
  ,dma2bpt_req_valid
  ,ipipe_rdy_p
  ,dma2bpt_req_ready
  ,ipipe_pd_p
  ,ipipe_vld_p
  );
input          nvdla_core_clk;
input          nvdla_core_rstn;
input  [NVDLA_DMA_WR_REQ-1:0] dma2bpt_req_pd;
input          dma2bpt_req_valid;
input          ipipe_rdy_p;
output         dma2bpt_req_ready;
output [NVDLA_DMA_WR_REQ-1:0] ipipe_pd_p;
output         ipipe_vld_p;

//: my $k = NVDLA_DMA_WR_REQ;
//: &eperl::pipe(" -wid $k -is -do ipipe_pd_p -vo ipipe_vld_p -ri ipipe_rdy_p -di dma2bpt_req_pd -vi dma2bpt_req_valid -ro dma2bpt_req_ready ");


endmodule
