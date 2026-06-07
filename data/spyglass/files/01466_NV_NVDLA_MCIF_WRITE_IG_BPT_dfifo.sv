module NV_NVDLA_MCIF_WRITE_IG_BPT_dfifo (
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
input  [NVDLA_MEMIF_WIDTH-1:0] dfifo_wr_pd;
input         dfifo_rd_prdy;
output        dfifo_rd_pvld;
output [NVDLA_MEMIF_WIDTH-1:0] dfifo_rd_pd;


//: my $k = NVDLA_MEMIF_WIDTH;
//: &eperl::pipe(" -wid $k -is -do dfifo_rd_pd -vo dfifo_rd_pvld -ri dfifo_rd_prdy -di dfifo_wr_pd -vi dfifo_wr_pvld -ro dfifo_wr_prdy");


endmodule
