// Stub module definition to resolve ErrorAnalyzeBBox violations
module NV_NVDLA_SDP_HLS_Y_INT_ALU_pipe_p1 (
   input         nvdla_core_clk,
   input         nvdla_core_rstn,
   input  [31:0] alu_data_sync,
   input         alu_mux_prdy,
   input  [31:0] alu_op_mux,
   input         alu_sync_pvld,
   output [31:0] alu_data_reg,
   output        alu_mux_pvld,
   output [31:0] alu_op_reg,
   output        alu_sync_prdy
);
   reg [31:0] alu_data_reg_r;
   reg [31:0] alu_op_reg_r;
   reg        alu_mux_pvld_r;

   assign alu_data_reg = alu_data_reg_r;
   assign alu_op_reg = alu_op_reg_r;
   assign alu_mux_pvld = alu_mux_pvld_r;

   assign alu_sync_prdy = alu_mux_prdy;

   always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
      if (!nvdla_core_rstn) begin
         alu_data_reg_r <= 0;
         alu_op_reg_r   <= 0;
         alu_mux_pvld_r <= 1'b0;
      end else begin
         if (alu_sync_pvld && alu_mux_prdy) begin
            alu_data_reg_r <= alu_data_sync;
            alu_op_reg_r   <= alu_op_mux;
            alu_mux_pvld_r <= 1'b1;
         end else if (alu_mux_prdy) begin
             alu_mux_pvld_r <= 1'b0;
         end
      end
   end
endmodule
