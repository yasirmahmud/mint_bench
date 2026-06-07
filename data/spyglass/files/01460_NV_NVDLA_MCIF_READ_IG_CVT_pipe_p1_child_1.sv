module NV_NVDLA_MCIF_READ_IG_CVT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,axi_cmd_pd
  ,axi_cmd_vld
  ,axi_cmd_rdy
  ,opipe_axi_pd
  ,opipe_axi_vld
  ,opipe_axi_rdy
  );

  parameter NVDLA_MEM_ADDRESS_WIDTH = 32;

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [NVDLA_MEM_ADDRESS_WIDTH+5:0] axi_cmd_pd;
input         axi_cmd_vld;
output        axi_cmd_rdy;
output [NVDLA_MEM_ADDRESS_WIDTH+5:0] opipe_axi_pd;
output        opipe_axi_vld;
input         opipe_axi_rdy;

//: my $w = eval(NVDLA_MEM_ADDRESS_WIDTH+6);
//: &eperl::pipe(" -wid $w -is -do opipe_axi_pd -vo opipe_axi_vld -ri opipe_axi_rdy -di axi_cmd_pd -vi axi_cmd_vld -ro axi_cmd_rdy");


endmodule
