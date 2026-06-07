module NV_NVDLA_MCIF_READ_IG_ARB_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,bpt2arb_req_pd
  ,bpt2arb_req_valid
  ,bpt2arb_req_ready
  ,arb_src_pd
  ,arb_src_vld
  ,arb_src_rdy
);

parameter NVDLA_DMA_RD_IG_PW = 32;

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [NVDLA_DMA_RD_IG_PW-1:0] bpt2arb_req_pd;
input         bpt2arb_req_valid;
output        bpt2arb_req_ready;
output [NVDLA_DMA_RD_IG_PW-1:0] arb_src_pd;
output        arb_src_vld;
input         arb_src_rdy;


// Internal registers for the single-stage pipeline
reg  [NVDLA_DMA_RD_IG_PW-1:0] arb_src_pd_reg;
reg                           arb_src_vld_reg;

// Combinational logic for upstream ready signal
// This stage is ready to accept data if downstream is ready OR this stage is empty
assign bpt2arb_req_ready = arb_src_rdy || !arb_src_vld_reg;

// Assign outputs from internal registers
assign arb_src_pd  = arb_src_pd_reg;
assign arb_src_vld = arb_src_vld_reg;

// Sequential logic for register updates
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    // Asynchronous reset: clear valid bit and data
    arb_src_vld_reg <= 1'b0;
    arb_src_pd_reg  <= {NVDLA_DMA_RD_IG_PW{1'b0}}; // Initialize data to 0
  end else begin
    // Conditions for data transfer:
    // 'push' from upstream: bpt2arb_req_valid && bpt2arb_req_ready
    // 'pop' to downstream: arb_src_vld_reg && arb_src_rdy

    if (arb_src_vld_reg && arb_src_rdy) begin
      // Data is being popped from this stage by downstream
      if (bpt2arb_req_valid && bpt2arb_req_ready) {
        // New data is also being pushed into this stage simultaneously
        arb_src_pd_reg  <= bpt2arb_req_pd; // Load new data
        arb_src_vld_reg <= 1'b1;           // Stage remains valid (old data replaced by new)
      } else {
        // No new data is being pushed, so stage becomes empty after pop
        arb_src_vld_reg <= 1'b0;
      }
    } else if (bpt2arb_req_valid && bpt2arb_req_ready) {
      // Data is being pushed into this stage, and it was not popped (either empty or full but downstream not ready)
      arb_src_pd_reg  <= bpt2arb_req_pd; // Load new data
      arb_src_vld_reg <= 1'b1;           // Stage becomes valid
    }
    // If neither a pop nor a push (and not a simultaneous transfer) occurs,
    // the registers hold their current values.
  end
end


endmodule
