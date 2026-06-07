module NV_NVDLA_RUBIK_fifo (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,idata_prdy
  ,idata_pvld
  ,idata_pd
  ,odata_prdy
  ,odata_pvld
  ,odata_pd
  ,pwrbus_ram_pd
);

input  nvdla_core_clk;
input  nvdla_core_rstn;
output idata_prdy;
input  idata_pvld;
input  [255:0] idata_pd;
input  odata_prdy;
output odata_pvld;
output [255:0] odata_pd;
input  [31:0] pwrbus_ram_pd;

// This is a placeholder 1-stage register-based FIFO implementation
// to resolve the black-box (BBox) error for linting purposes.
// It provides the necessary ready/valid handshaking for simulation
// without changing the functional behavior of the parent module.

reg  [255:0] fifo_data_r;
reg          fifo_vld_r;

// Declare push_en and pop_en as wires outside the always block
wire push_en;
wire pop_en;

// Input Ready (idata_prdy): Ready to accept if empty, or if full but popping current data
assign idata_prdy = !fifo_vld_r || (fifo_vld_r && odata_prdy);

// Output Valid (odata_pvld): Output is valid if fifo_vld_r is set
assign odata_pvld = fifo_vld_r;
assign odata_pd   = fifo_data_r;

// Assign push_en and pop_en using continuous assignments
// A push happens if input valid is high and FIFO is ready
assign push_en = idata_pvld && idata_prdy;
// A pop happens if output valid is high and consumer is ready
assign pop_en  = fifo_vld_r && odata_prdy;

// FIFO register update logic
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    fifo_vld_r  <= 1'b0;
    fifo_data_r <= 256'b0;
  end else begin
    if (push_en) begin
      // If data is pushed, update the data register
      fifo_data_r <= idata_pd;
    end

    // Update valid bit
    if (push_en && !pop_en) begin
      // Data pushed, but not popped -> FIFO becomes/stays full
      fifo_vld_r <= 1'b1;
    end else if (!push_en && pop_en) begin
      // Data popped, but no new data pushed -> FIFO becomes empty
      fifo_vld_r <= 1'b0;
    end
    // If (push_en && pop_en), data is replaced, fifo_vld_r remains 1'b1 (no change needed).
    // If (!push_en && !pop_en), fifo_vld_r remains unchanged.
  end
end

endmodule
