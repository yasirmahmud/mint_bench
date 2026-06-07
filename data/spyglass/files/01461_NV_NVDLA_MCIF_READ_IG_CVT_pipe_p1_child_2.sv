module NV_NVDLA_MCIF_READ_IG_CVT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,axi_cmd_pd
  ,axi_cmd_vld
  ,axi_cmd_rdy
  ,opipe_axi_pd
  ,opipe_axi_vld
  ,opipe_axi_rdy
  );

  parameter NVDLA_MEM_ADDRESS_WIDTH = 32;

input         nvdla_core_clk;
input         nvdla_core_rstn;
input  [NVDLA_MEM_ADDRESS_WIDTH+5:0] axi_cmd_pd;
input         axi_cmd_vld;
output        axi_cmd_rdy;
output [NVDLA_MEM_ADDRESS_WIDTH+5:0] opipe_axi_pd;
output        opipe_axi_vld;
input         opipe_axi_rdy;

// Internal registers for the pipeline stage
reg [NVDLA_MEM_ADDRESS_WIDTH+5:0] pipe_data_reg;
reg                               pipe_valid_reg;

// Ready signal for the input interface
assign axi_cmd_rdy = opipe_axi_rdy || !pipe_valid_reg;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    // Reset condition
    pipe_valid_reg <= 1'b0;
    pipe_data_reg  <= {NVDLA_MEM_ADDRESS_WIDTH+6{1'b0}};
  end else begin
    // Output handshake: if output is ready and data is valid, clear valid
    if (pipe_valid_reg && opipe_axi_rdy) begin
      pipe_valid_reg <= 1'b0;
    end
    // Input handshake: if input is valid and the pipe is ready, load new data
    if (axi_cmd_vld && axi_cmd_rdy) begin
      pipe_data_reg  <= axi_cmd_pd;
      pipe_valid_reg <= 1'b1;
    end
  end
end

// Assign outputs from the pipeline registers
assign opipe_axi_pd  = pipe_data_reg;
assign opipe_axi_vld = pipe_valid_reg;


endmodule
