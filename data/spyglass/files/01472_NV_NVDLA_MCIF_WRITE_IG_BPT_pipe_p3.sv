module NV_NVDLA_MCIF_WRITE_IG_BPT_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,in_cmd_rdy
  ,ipipe_cmd_pd
  ,ipipe_cmd_vld
  ,in_cmd_pd
  ,in_cmd_vld
  ,ipipe_cmd_rdy
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
input         in_cmd_rdy;
input  [NVDLA_DMA_WR_CMD-1:0] ipipe_cmd_pd;
input         ipipe_cmd_vld;
output [NVDLA_DMA_WR_CMD-1:0] in_cmd_pd;
output        in_cmd_vld;
output        ipipe_cmd_rdy;

//: my $k = NVDLA_DMA_WR_CMD; 
//: &eperl::pipe(" -wid $k -do in_cmd_pd -vo in_cmd_vld -ri in_cmd_rdy -di ipipe_cmd_pd -vi ipipe_cmd_vld -ro ipipe_cmd_rdy");


endmodule
