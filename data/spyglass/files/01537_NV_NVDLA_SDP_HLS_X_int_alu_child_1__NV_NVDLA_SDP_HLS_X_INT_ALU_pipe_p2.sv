module NV_NVDLA_SDP_HLS_X_INT_ALU_pipe_p2 (
   input               nvdla_core_clk
  ,input               nvdla_core_rstn
  ,input  [32:0]       alu_dout
  ,input               alu_final_prdy
  ,input               alu_shift_pvld
  ,output reg [32:0]   alu_data_final
  ,output reg          alu_final_pvld
  ,output              alu_shift_prdy
);
   // Dummy for linting. Assume single-stage pipeline.
   // Input ready if output ready. Output valid reflects input valid after capture.
   assign alu_shift_prdy = alu_final_prdy; // This stage is ready if the next stage is ready

   always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
      if (!nvdla_core_rstn) begin
         alu_data_final <= 33'b0;
         alu_final_pvld <= 1'b0;
      end else begin
         if (alu_shift_pvld && alu_shift_prdy) begin // Capture if input valid AND this stage is ready
            alu_data_final <= alu_dout;
            alu_final_pvld <= 1'b1; // Output becomes valid
         end else if (!alu_shift_pvld && alu_shift_prdy) begin // No input valid, and this stage is ready for new input
            alu_final_pvld <= 1'b0; // De-assert output valid if no new data to pass
         end
         // else if (!alu_shift_prdy) hold state (stall)
      end
   end
endmodule
