module NV_NVDLA_MCIF_WRITE_EG_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,iflop_axi_axid
  ,iflop_axi_vld
  ,iflop_axi_rdy
  ,noc2mcif_axi_b_bid
  ,noc2mcif_axi_b_bvalid
  ,noc2mcif_axi_b_bready
  );
input         nvdla_core_clk;
input         nvdla_core_rstn;
output [2:0]  iflop_axi_axid;
output        iflop_axi_vld;
input         iflop_axi_rdy;
input  [2:0]  noc2mcif_axi_b_bid;
input         noc2mcif_axi_b_bvalid;
output        noc2mcif_axi_b_bready;

//: &eperl::pipe(" -wid 3 -is -di noc2mcif_axi_b_bid -vi noc2mcif_axi_b_bvalid -ro noc2mcif_axi_b_bready -do iflop_axi_axid -vo iflop_axi_vld -ri iflop_axi_rdy ");


endmodule
