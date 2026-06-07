module NV_NVDLA_DMAIF_rdrsp (
   input      nvdla_core_clk      
  ,input      nvdla_core_rstn     
  `ifdef NVDLA_SECONDARY_MEMIF_ENABLE
  ,input   [DMA_DATA_WIDTH-1:0]   cvif_rd_rsp_pd   
  ,input                          cvif_rd_rsp_valid
  ,output                         cvif_rd_rsp_ready
  `endif
  ,input   [DMA_DATA_WIDTH-1:0]   mcif_rd_rsp_pd    
  ,input                          mcif_rd_rsp_valid 
  ,output                         mcif_rd_rsp_ready 

  ,output  [DMA_DATA_WIDTH-1:0]   dmaif_rd_rsp_pd
  ,output                         dmaif_rd_rsp_pvld
  ,input                          dmaif_rd_rsp_prdy
);

    // Local parameters for bit widths derived from NVDLA_... macros
    localparam DMAIF_WIDTH = `NVDLA_MEMIF_WIDTH;
    // Calculation of MASK_WIDTH from Eperl: $mask = int($dmaif/NVDLA_MEMORY_ATOMIC_SIZE/NVDLA_BPE);
    // Integer division is used to ensure compatibility with Verilog parameter calculations.
    localparam MASK_WIDTH = DMAIF_WIDTH / (`NVDLA_MEMORY_ATOMIC_SIZE * `NVDLA_BPE); 
    localparam DMA_DATA_WIDTH = DMAIF_WIDTH + MASK_WIDTH;

    //////////////////////////////////////////////
    // Internal wires for the pipeline stages and muxing
    wire                    dma_rd_rsp_rdy; // Unified ready for MCIF/CVIF pipes
    wire                    dma_rd_rsp_vld; // Unified valid from MCIF/CVIF mux
    wire  [DMA_DATA_WIDTH-1:0] dma_rd_rsp_pd; // Unified data from MCIF/CVIF mux

    // Wires for MCIF pipeline stage outputs
    wire  [DMA_DATA_WIDTH-1:0] mcif_rd_rsp_pd_d0;
    wire                       mcif_rd_rsp_valid_d0;
    
    // Wires for CVIF pipeline stage outputs (conditionally declared)
    `ifdef NVDLA_SECONDARY_MEMIF_ENABLE
    wire  [DMA_DATA_WIDTH-1:0] cvif_rd_rsp_pd_d0;
    wire                       cvif_rd_rsp_valid_d0;
    wire                       cv_dma_rd_rsp_rdy; // CVIF's specific ready input
    `endif

    // Wire for the final output pipeline stage's internal ready signal
    wire                       dma_rd_rsp_rdy_f;

    ///////////////////////////////////////
    // pipe before mux
    ///////////////////////////////////////
    // Replace &eperl::pipe with an instance of NV_NVDLA_pipe_stage
    NV_NVDLA_pipe_stage #( 
        .DATA_WIDTH (DMA_DATA_WIDTH)
    ) pipe_mcif (
        .nvdla_core_clk      (nvdla_core_clk),
        .nvdla_core_rstn     (nvdla_core_rstn),
        .di                  (mcif_rd_rsp_pd),
        .vi                  (mcif_rd_rsp_valid),
        .ro                  (mcif_rd_rsp_ready),
        .do                  (mcif_rd_rsp_pd_d0),
        .vo                  (mcif_rd_rsp_valid_d0),
        .ri                  (dma_rd_rsp_rdy)
    );

    `ifdef NVDLA_SECONDARY_MEMIF_ENABLE
    assign cv_dma_rd_rsp_rdy = dma_rd_rsp_rdy; // CVIF ready is tied to the unified ready
    NV_NVDLA_pipe_stage #(
        .DATA_WIDTH (DMA_DATA_WIDTH)
    ) pipe_cvif (
        .nvdla_core_clk      (nvdla_core_clk),
        .nvdla_core_rstn     (nvdla_core_rstn),
        .di                  (cvif_rd_rsp_pd),
        .vi                  (cvif_rd_rsp_valid),
        .ro                  (cvif_rd_rsp_ready),
        .do                  (cvif_rd_rsp_pd_d0),
        .vo                  (cvif_rd_rsp_valid_d0),
        .ri                  (cv_dma_rd_rsp_rdy) // Using cv_dma_rd_rsp_rdy as per original Eperl
    );
    `endif // NVDLA_SECONDARY_MEMIF_ENABLE

    ///////////////////////////////////////
    //mux
    ///////////////////////////////////////
    `ifdef NVDLA_SECONDARY_MEMIF_ENABLE
    // The original design implicitly assumed that mcif_rd_rsp_valid_d0 and cvif_rd_rsp_valid_d0
    // would not be simultaneously asserted, based on a commented `eperl::assert` directive.
    // We preserve this functional assumption for the data multiplexing.
    assign dma_rd_rsp_vld = mcif_rd_rsp_valid_d0 | cvif_rd_rsp_valid_d0;
    assign dma_rd_rsp_pd = mcif_rd_rsp_valid_d0 ? mcif_rd_rsp_pd_d0 : cvif_rd_rsp_pd_d0;
    `else
    assign dma_rd_rsp_vld = mcif_rd_rsp_valid_d0; 
    assign dma_rd_rsp_pd = mcif_rd_rsp_pd_d0;
    `endif

    ///////////////////////////////////////
    // pipe after mux
    ///////////////////////////////////////
    // Replace &eperl::pipe with an instance of NV_NVDLA_pipe_stage
    NV_NVDLA_pipe_stage #(
        .DATA_WIDTH (DMA_DATA_WIDTH)
    ) pipe_dmaif_out (
        .nvdla_core_clk      (nvdla_core_clk),
        .nvdla_core_rstn     (nvdla_core_rstn),
        .di                  (dma_rd_rsp_pd),
        .vi                  (dma_rd_rsp_vld),
        .ro                  (dma_rd_rsp_rdy_f),
        .do                  (dmaif_rd_rsp_pd),
        .vo                  (dmaif_rd_rsp_pvld),
        .ri                  (dmaif_rd_rsp_prdy)
    );

    // The unified ready signal for upstream pipelines is derived from the final pipe's ready output.
    assign dma_rd_rsp_rdy = dma_rd_rsp_rdy_f;

endmodule
