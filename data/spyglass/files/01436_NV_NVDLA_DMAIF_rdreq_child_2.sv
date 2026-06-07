module NV_NVDLA_DMAIF_rdreq #(
   parameter NVDLA_MEM_ADDRESS_WIDTH = 32
) (
   input                      nvdla_core_clk
  ,input                      nvdla_core_rstn
  ,input                      reg2dp_src_ram_type
`ifdef NVDLA_SECONDARY_MEMIF_ENABLE
  ,output [NVDLA_MEM_ADDRESS_WIDTH+14:0]   cvif_rd_req_pd
  ,output                     cvif_rd_req_valid
  ,input                      cvif_rd_req_ready
`endif
  ,output [NVDLA_MEM_ADDRESS_WIDTH+14:0]   mcif_rd_req_pd
  ,output                     mcif_rd_req_valid
  ,input                      mcif_rd_req_ready

  ,input  [NVDLA_MEM_ADDRESS_WIDTH+14:0]  dmaif_rd_req_pd
  ,input                      dmaif_rd_req_vld
  ,output                     dmaif_rd_req_rdy
);


//////////////////////////////////////////////
// Wire declarations
//////////////////////////////////////////////
wire        mc_dma_rd_req_vld;
wire        mc_dma_rd_req_rdy;
wire        mc_rd_req_rdyi;
wire        dma_rd_req_ram_type;
wire        rd_req_rdyi;
//////////////////////////////////////////////

// Assign dma_rd_req_ram_type based on input
assign dma_rd_req_ram_type = reg2dp_src_ram_type;

// MCIF path logic
assign mc_dma_rd_req_vld = dmaif_rd_req_vld & (dma_rd_req_ram_type == 1'b1);

// The eperl::pipe macro for MCIF has been replaced with direct Verilog assignments.
// This assumes a combinatorial valid-ready handshake, as implied by the direct assignment
// of the 'ready' input to the 'ready_f' signal, and direct propagation of data/valid.
// Original eperl: //: &eperl::pipe(" -wid $dmabw -is -do mcif_rd_req_pd -vo mcif_rd_req_valid -ri mcif_rd_req_ready -di dmaif_rd_req_pd -vi mc_dma_rd_req_vld -ro mc_dma_rd_req_rdy_f  ");
assign mcif_rd_req_pd    = dmaif_rd_req_pd;     // Output Data (mcif_rd_req_pd) from Input Data (dmaif_rd_req_pd)
assign mcif_rd_req_valid = mc_dma_rd_req_vld;   // Output Valid (mcif_rd_req_valid) from Input Valid (mc_dma_rd_req_vld)
wire mc_dma_rd_req_rdy_f = mcif_rd_req_ready; // Ready output from pipe (mc_dma_rd_req_rdy_f) from Downstream Ready (mcif_rd_req_ready)

assign mc_dma_rd_req_rdy = mc_dma_rd_req_rdy_f;
assign mc_rd_req_rdyi = mc_dma_rd_req_rdy & (dma_rd_req_ram_type == 1'b1);

// CVIF path logic (conditional) - #ifdef directives converted to `ifdef
`ifdef NVDLA_SECONDARY_MEMIF_ENABLE
wire        cv_dma_rd_req_vld;
wire        cv_rd_req_rdyi;
wire        cv_dma_rd_req_rdy;

assign cv_dma_rd_req_vld = dmaif_rd_req_vld & (dma_rd_req_ram_type == 1'b0);

// eperl generated declarations/assignments for cv_dma_rd_req_pd are now explicit Verilog
// Original eperl: //: print "wire [${dmabw}-1:0] cv_dma_rd_req_pd; \n";
wire [NVDLA_MEM_ADDRESS_WIDTH+14:0] cv_dma_rd_req_pd;
// Original eperl: //: print "assign cv_dma_rd_req_pd = dmaif_rd_req_pd; \n";
assign cv_dma_rd_req_pd = dmaif_rd_req_pd;

// The eperl::pipe macro for CVIF has been replaced with direct Verilog assignments.
// Original eperl: //: &eperl::pipe(" -wid $dmabw -is -do cvif_rd_req_pd -vo cvif_rd_req_valid -ri cvif_rd_req_ready -di cv_dma_rd_req_pd -vi cv_dma_rd_req_vld -ro cv_dma_rd_req_rdy_f  ");
assign cvif_rd_req_pd    = cv_dma_rd_req_pd;    // Output Data (cvif_rd_req_pd) from Input Data (cv_dma_rd_req_pd)
assign cvif_rd_req_valid = cv_dma_rd_req_vld;   // Output Valid (cvif_rd_req_valid) from Input Valid (cv_dma_rd_req_vld)
wire cv_dma_rd_req_rdy_f = cvif_rd_req_ready; // Ready output from pipe (cv_dma_rd_req_rdy_f) from Downstream Ready (cvif_rd_req_ready)

assign cv_dma_rd_req_rdy = cv_dma_rd_req_rdy_f;
assign cv_rd_req_rdyi = cv_dma_rd_req_rdy & (dma_rd_req_ram_type == 1'b0);

assign rd_req_rdyi = mc_rd_req_rdyi | cv_rd_req_rdyi;
`else
assign rd_req_rdyi = mc_rd_req_rdyi;
`endif

// DMAIF ready signal
assign dmaif_rd_req_rdy= rd_req_rdyi;


endmodule
