module NV_NVDLA_SDP_HLS_X_INT_ALU_pipe_p1 (
   input               nvdla_core_clk
  ,input               nvdla_core_rstn
  ,input  [31:0]       alu_data_sync
  ,input  [31:0]       alu_op_shift
  ,input               alu_shift_prdy
  ,input               alu_sync_pvld
  ,output reg [31:0]   alu_data_reg
  ,output reg          alu_shift_pvld
  ,output              alu_sync_prdy
  ,output reg [31:0]   operand_shift
);
   // Dummy for linting. Assume single-stage pipeline.
   // Input ready if output ready. Output valid reflects input valid after capture.
   assign alu_sync_prdy = alu_shift_prdy; // This stage is ready if the next stage is ready

   always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
      if (!nvdla_core_rstn) begin
         alu_data_reg    <= 32'b0;
         operand_shift   <= 32'b0;
         alu_shift_pvld  <= 1'b0;
      end else begin
         if (alu_sync_pvld && alu_sync_prdy) begin // Capture if input valid AND this stage is ready
            alu_data_reg   <= alu_data_sync;
            operand_shift  <= alu_op_shift;
            alu_shift_pvld <= 1'b1; // Output becomes valid
         end else if (!alu_sync_pvld && alu_sync_prdy) begin // No input valid, and this stage is ready for new input
            alu_shift_pvld <= 1'b0; // De-assert output valid if no new data to pass
         end
         // else if (!alu_sync_prdy) hold state (stall)
      end
   end
endmodule
