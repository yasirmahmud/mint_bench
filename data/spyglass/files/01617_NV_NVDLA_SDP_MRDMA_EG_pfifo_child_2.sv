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

parameter AM_DW = 32; // Default data width, can be overridden

input         nvdla_core_clk;
input         nvdla_core_rstn;
output        pfifo_wr_prdy;
input         pfifo_wr_pvld;
input  [AM_DW-1:0] pfifo_wr_pd;
input         pfifo_rd_prdy;
output        pfifo_rd_pvld;
output [AM_DW-1:0] pfifo_rd_pd;


// Internal registers for the single-stage pipelined FIFO
reg  [AM_DW-1:0] data_reg;
reg              data_valid_reg;

// Assign outputs based on internal registers
assign pfifo_rd_pd   = data_reg;
assign pfifo_rd_pvld = data_valid_reg;

// Write ready logic: The FIFO is ready to accept new data if it's empty,
// or if it's currently full but the data is being read out in the same cycle.
assign pfifo_wr_prdy = !data_valid_reg || (data_valid_reg && pfifo_rd_prdy);

// Sequential logic for the pipeline stage (1-stage FIFO)
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        // Asynchronous reset
        data_valid_reg <= 1'b0;
        data_reg       <= {AM_DW{1'b0}}; // Initialize data to all zeros
    end else begin
        // Logic to update data_valid_reg:
        // If data is being read out (pfifo_rd_prdy is asserted and data_valid_reg is high),
        // the stage becomes empty or will be overwritten.
        if (pfifo_rd_prdy && data_valid_reg) begin
            data_valid_reg <= 1'b0; // Mark the stage as becoming empty (unless new data is written)
        end
        
        // Logic to write new data into the stage:
        // If the writer is valid (pfifo_wr_pvld) and the stage is ready (pfifo_wr_prdy),
        // then new data is stored.
        if (pfifo_wr_pvld && pfifo_wr_prdy) begin
            data_reg       <= pfifo_wr_pd;   // Store new data
            data_valid_reg <= 1'b1;          // Mark the stage as becoming full with new data
        end
    end
end


endmodule
