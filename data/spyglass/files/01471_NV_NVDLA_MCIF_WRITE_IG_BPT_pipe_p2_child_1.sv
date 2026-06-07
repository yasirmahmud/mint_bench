module NV_NVDLA_MCIF_WRITE_IG_BPT_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,ipipe_pd_p
  ,ipipe_rdy
  ,ipipe_vld_p
  ,ipipe_pd
  ,ipipe_rdy_p
  ,ipipe_vld
  );
parameter NVDLA_DMA_WR_REQ = 32;

input          nvdla_core_clk;
input          nvdla_core_rstn;
input  [NVDLA_DMA_WR_REQ-1:0] ipipe_pd_p;
input          ipipe_rdy;
input          ipipe_vld_p;
output [NVDLA_DMA_WR_REQ-1:0] ipipe_pd;
output         ipipe_rdy_p;
output         ipipe_vld;

//: my $k = NVDLA_DMA_WR_REQ;
//: &eperl::pipe(" -wid $k -is -do ipipe_pd -vo ipipe_vld -ri ipipe_rdy -di ipipe_pd_p -vi ipipe_vld_p -ro ipipe_rdy_p ");


endmodule
