module NV_NVDLA_SDP_CMUX_pipe_p1 (
   nvdla_core_clk        //|< i
  ,nvdla_core_rstn       //|< i
  ,cacc2sdp_pd           //|< i
  ,cacc2sdp_valid        //|< i
  ,cacc_rdy              //|< i
  ,cacc2sdp_ready        //|> o
  ,cacc_pd               //|> o
  ,cacc_vld              //|> o
  );

input  nvdla_core_clk;
input  nvdla_core_rstn;
input  [513:0] cacc2sdp_pd;
input  cacc2sdp_valid;
input  cacc_rdy; // Downstream ready for this pipe's output
output cacc2sdp_ready; // Ready for upstream (cacc2sdp) input
output [513:0] cacc_pd; // Pipe's output data
output cacc_vld; // Pipe's output valid

reg    [513:0] pipe_data_reg;
reg    pipe_valid_reg;

// Input side handshake signals
wire   pipe_in_fire = cacc2sdp_valid && cacc2sdp_ready;
// Output side handshake signals
wire   pipe_out_fire = cacc_vld && cacc_rdy;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
  if (!nvdla_core_rstn) begin
    pipe_data_reg <= {514{1'b0}};
    pipe_valid_reg <= 1'b0;
  end else begin
    if (pipe_out_fire) begin // Downstream consumes data, clear valid
      pipe_valid_reg <= 1'b0;
    end
    if (pipe_in_fire) begin // Upstream sends data, register it
      pipe_data_reg <= cacc2sdp_pd;
      pipe_valid_reg <= 1'b1;
    end
  end
end

// Pipe is ready to accept input if its output is empty or is being consumed
assign cacc2sdp_ready = !pipe_valid_reg || pipe_out_fire;
assign cacc_pd = pipe_data_reg;
assign cacc_vld = pipe_valid_reg;

endmodule
