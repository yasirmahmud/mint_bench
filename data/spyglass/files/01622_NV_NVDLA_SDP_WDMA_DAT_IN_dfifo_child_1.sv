module NV_NVDLA_SDP_WDMA_DAT_IN_dfifo #(
  parameter AM_DW = 32
) (
      nvdla_core_clk
    , nvdla_core_rstn
    , dfifo_wr_prdy
    , dfifo_wr_pvld
    , dfifo_wr_pd
    , dfifo_rd_prdy
    , dfifo_rd_pvld
    , dfifo_rd_pd
    );

input         nvdla_core_clk;
input         nvdla_core_rstn;
output        dfifo_wr_prdy;
input         dfifo_wr_pvld;
input  [AM_DW-1:0] dfifo_wr_pd;
input         dfifo_rd_prdy;
output        dfifo_rd_pvld;
output [AM_DW-1:0] dfifo_rd_pd;


//: my $dw = AM_DW;
//: &eperl::pipe("-is -wid $dw -do dfifo_rd_pd -vo dfifo_rd_pvld -ri dfifo_rd_prdy -di dfifo_wr_pd -vi dfifo_wr_pvld -ro dfifo_wr_prdy");


endmodule
