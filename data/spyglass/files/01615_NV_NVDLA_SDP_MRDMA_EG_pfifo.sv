module NV_NVDLA_SDP_MRDMA_EG_pfifo (
      nvdla_core_clk
    , nvdla_core_rstn
    , pfifo_wr_prdy
    , pfifo_wr_pvld
    , pfifo_wr_pd
    , pfifo_rd_prdy
    , pfifo_rd_pvld
    , pfifo_rd_pd
    );

input         nvdla_core_clk;
input         nvdla_core_rstn;
output        pfifo_wr_prdy;
input         pfifo_wr_pvld;
input  [AM_DW-1:0] pfifo_wr_pd;
input         pfifo_rd_prdy;
output        pfifo_rd_pvld;
output [AM_DW-1:0] pfifo_rd_pd;


//: my $dw = AM_DW;
//: &eperl::pipe("-is -wid $dw -do pfifo_rd_pd -vo pfifo_rd_pvld -ri pfifo_rd_prdy -di pfifo_wr_pd -vi pfifo_wr_pvld -ro pfifo_wr_prdy");


endmodule
